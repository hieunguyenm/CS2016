//#define TEST_STARVE
//#define TEST_LIVELOCK
//#define STUPID_PHILOSOPHERS
#define SMART_PHILOSOPHERS
#define N 5

byte forks[N];
byte count_eat;
bool think[N], hungry[N], eat[N] = false;
bool has_eaten = false;

init{

    atomic{
        byte i = 0;
        do :: i < (N - 1) -> run Philosopher(i); i++;
           :: else -> break;
        od;
    }
    
    //run Philosopher(1);
    //run Philosopher(2);
    //run Philosopher(3);
}

#ifdef STUPID_PHILOSOPHERS
active proctype Philosopher(byte id){
think_action: 
    atomic{think[id] = true; hungry[id] = false; eat[id] = false;}
    if
        :: atomic{forks[id] == 0 -> forks[id] = id + 1;};
        :: atomic{forks[(id + 1) % N] == 0 -> forks[(id + 1) % N] = id + 1;};
    fi;

hungry_action:
    atomic{think[id] = false; hungry[id] = true; eat[id] = false;}
    if
        :: atomic{
            forks[id] == id + 1 -> forks[(id +1) % N] == 0 -> forks[(id + 1) % N] = id + 1;
            count_eat++;
        }
        :: atomic{
            forks[id] == 0 -> forks[(id + 1) % N] == id + 1 -> forks[id] = id + 1;
            count_eat++;
        }
    fi;

eat_action: 
    atomic{think[id] = false; hungry[id] = false; eat[id] = true;}
    d_step{
        count_eat--;
        forks[(id + 1) % N] = 0;
    }
    forks[id] = 0;
    has_eaten = true;
    goto think_action;
}
#endif

#ifdef SMART_PHILOSOPHERS
active proctype Philosopher(byte id){
    byte left = id; 
    byte right = (id + 1) % N;
think_action: 
    atomic{think[id] = true; hungry[id] = false; eat[id] = false;}

hungry_action:
    atomic{think[id] = false; hungry[id] = true; eat[id] = false;}
    if :: left < right;
         atomic{
            forks[left] == -1 -> forks[left] = id;
        }
         atomic{
            forks[right] == -1 -> forks[right] = id;
        }
        :: right < left;
        atomic{
            forks[right] == -1 -> forks[right] = id;
        }
         atomic{
            forks[left] == -1 -> forks[left] = id;
        }
    fi;

eat_action: 
    atomic{think[id] = false; hungry[id] = false; eat[id] = true;}
done_action:
    forks[right] = -1; forks[left] = -1;
    goto think_action;
}
#endif

#ifdef TEST_STARVE
never{
T0_init:
    do
        ::(! ((eat[0])) && (hungry[0])) -> goto accept_S4
        ::(1) -> goto T0_init
    od;
accept_S4:
    do
        ::(! ((eat[0]))) -> goto accept_S4
    od;
}
#endif

#ifdef TEST_LIVELOCK
never{
T0_init:
    do
        :: (! ((has_eaten)) && (np_)) -> goto accept_S6
        :: (! ((has_eaten))) -> goto T0_init
    od;
    accept_S6:
    do
        :: (! ((has_eaten)) && (np_)) -> goto accept_S6
    od;
}
#endif

