#define N 5

byte forks[N];
byte count_eat;

init{
    /*
    atomic{
        byte i = 0;
        do :: i < N -> run Philosopher(i); i++;
           :: else -> break;
        od;
    }
    */
    run Philosopher(1);
    //run Philosopher(3);
}

active proctype Philosopher(byte id){
think: 
    if
        :: atomic{forks[id] == 0 -> forks[id] = id + 1;};
        :: atomic{forks[(id + 1) % N] == 0 -> forks[(id + 1) % N] = id + 1;};
    fi;

hungry:
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

eat: 
    d_step{
        count_eat--;
        forks[(id + 1) % N] = 0;
    }
    forks[id] = 0;
    goto think;
}

