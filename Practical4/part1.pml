byte n = 0, finish = 0;

active proctype P() {
    byte temp, counter =0;
    do :: counter == 2 -> break
       :: else ->
            temp = n;
            temp++;
            n = temp;
            counter++;
    od;
    finish++;
}

active proctype Q() {
    byte counter = 0;
    do :: counter == 2 -> break
       :: else ->
            n++;
            counter++;
    od;
    finish++;
}

active proctype whenFinished() {
    finish == 2;
    printf("n = %d\n", n);
    assert(n == 4);
}

