#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC Philosopher */
	case 3: // STATE 1 - dining_philosophers.pml:22 - [((forks[id]==0))] (19:0:1 - 1)
		IfNotBlocked
		reached[1][1] = 1;
		if (!((((int)now.forks[ Index(((int)((P1 *)this)->id), 5) ])==0)))
			continue;
		/* merge: forks[id] = (id+1)(0, 2, 19) */
		reached[1][2] = 1;
		(trpt+1)->bup.oval = ((int)now.forks[ Index(((int)((P1 *)this)->id), 5) ]);
		now.forks[ Index(((P1 *)this)->id, 5) ] = (((int)((P1 *)this)->id)+1);
#ifdef VAR_RANGES
		logval("forks[Philosopher:id]", ((int)now.forks[ Index(((int)((P1 *)this)->id), 5) ]));
#endif
		;
		/* merge: .(goto)(0, 8, 19) */
		reached[1][8] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 4: // STATE 4 - dining_philosophers.pml:23 - [((forks[((id+1)%5)]==0))] (19:0:1 - 1)
		IfNotBlocked
		reached[1][4] = 1;
		if (!((((int)now.forks[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ])==0)))
			continue;
		/* merge: forks[((id+1)%5)] = (id+1)(0, 5, 19) */
		reached[1][5] = 1;
		(trpt+1)->bup.oval = ((int)now.forks[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ]);
		now.forks[ Index(((((P1 *)this)->id+1)%5), 5) ] = (((int)((P1 *)this)->id)+1);
#ifdef VAR_RANGES
		logval("forks[((Philosopher:id+1)%5)]", ((int)now.forks[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ]));
#endif
		;
		/* merge: .(goto)(0, 8, 19) */
		reached[1][8] = 1;
		;
		_m = 3; goto P999; /* 2 */
	case 5: // STATE 9 - dining_philosophers.pml:29 - [((forks[id]==(id+1)))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][9] = 1;
		if (!((((int)now.forks[ Index(((int)((P1 *)this)->id), 5) ])==(((int)((P1 *)this)->id)+1))))
			continue;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 10 - dining_philosophers.pml:29 - [((forks[((id+1)%5)]==0))] (23:0:2 - 1)
		IfNotBlocked
		reached[1][10] = 1;
		if (!((((int)now.forks[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ])==0)))
			continue;
		/* merge: forks[((id+1)%5)] = (id+1)(23, 11, 23) */
		reached[1][11] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)now.forks[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ]);
		now.forks[ Index(((((P1 *)this)->id+1)%5), 5) ] = (((int)((P1 *)this)->id)+1);
#ifdef VAR_RANGES
		logval("forks[((Philosopher:id+1)%5)]", ((int)now.forks[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ]));
#endif
		;
		/* merge: count_eat = (count_eat+1)(23, 12, 23) */
		reached[1][12] = 1;
		(trpt+1)->bup.ovals[1] = ((int)count_eat);
		count_eat = (((int)count_eat)+1);
#ifdef VAR_RANGES
		logval("count_eat", ((int)count_eat));
#endif
		;
		/* merge: .(goto)(0, 20, 23) */
		reached[1][20] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 7: // STATE 14 - dining_philosophers.pml:33 - [((forks[id]==0))] (0:0:0 - 1)
		IfNotBlocked
		reached[1][14] = 1;
		if (!((((int)now.forks[ Index(((int)((P1 *)this)->id), 5) ])==0)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 15 - dining_philosophers.pml:33 - [((forks[((id+1)%5)]==(id+1)))] (23:0:2 - 1)
		IfNotBlocked
		reached[1][15] = 1;
		if (!((((int)now.forks[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ])==(((int)((P1 *)this)->id)+1))))
			continue;
		/* merge: forks[id] = (id+1)(23, 16, 23) */
		reached[1][16] = 1;
		(trpt+1)->bup.ovals = grab_ints(2);
		(trpt+1)->bup.ovals[0] = ((int)now.forks[ Index(((int)((P1 *)this)->id), 5) ]);
		now.forks[ Index(((P1 *)this)->id, 5) ] = (((int)((P1 *)this)->id)+1);
#ifdef VAR_RANGES
		logval("forks[Philosopher:id]", ((int)now.forks[ Index(((int)((P1 *)this)->id), 5) ]));
#endif
		;
		/* merge: count_eat = (count_eat+1)(23, 17, 23) */
		reached[1][17] = 1;
		(trpt+1)->bup.ovals[1] = ((int)count_eat);
		count_eat = (((int)count_eat)+1);
#ifdef VAR_RANGES
		logval("count_eat", ((int)count_eat));
#endif
		;
		/* merge: .(goto)(0, 20, 23) */
		reached[1][20] = 1;
		;
		_m = 3; goto P999; /* 3 */
	case 9: // STATE 23 - dining_philosophers.pml:39 - [D_STEP39]
		IfNotBlocked

		reached[1][23] = 1;
		reached[1][t->st] = 1;
		reached[1][tt] = 1;

		if (TstOnly) return 1;

		sv_save();
		S_023_0: /* 2 */
		count_eat = (((int)count_eat)-1);
#ifdef VAR_RANGES
		logval("count_eat", ((int)count_eat));
#endif
		;
S_024_0: /* 2 */
		now.forks[ Index(((((P1 *)this)->id+1)%5), 5) ] = 0;
#ifdef VAR_RANGES
		logval("forks[((Philosopher:id+1)%5)]", ((int)now.forks[ Index(((((int)((P1 *)this)->id)+1)%5), 5) ]));
#endif
		;
		goto S_026_0;
S_026_0: /* 1 */

#if defined(C_States) && (HAS_TRACK==1)
		c_update((uchar *) &(now.c_state[0]));
#endif
		_m = 3; goto P999;

	case 10: // STATE 24 - dining_philosophers.pml:43 - [forks[id] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[1][24] = 1;
		(trpt+1)->bup.oval = ((int)now.forks[ Index(((int)((P1 *)this)->id), 5) ]);
		now.forks[ Index(((P1 *)this)->id, 5) ] = 0;
#ifdef VAR_RANGES
		logval("forks[Philosopher:id]", ((int)now.forks[ Index(((int)((P1 *)this)->id), 5) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */

		 /* PROC :init: */
	case 11: // STATE 1 - dining_philosophers.pml:15 - [(run Philosopher(1))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		if (!(addproc(II, 1, 1, 1)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 12: // STATE 2 - dining_philosophers.pml:16 - [(run Philosopher(3))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][2] = 1;
		if (!(addproc(II, 1, 1, 3)))
			continue;
		_m = 3; goto P999; /* 0 */
	case 13: // STATE 3 - dining_philosophers.pml:17 - [-end-] (0:0:0 - 1)
		IfNotBlocked
		reached[0][3] = 1;
		if (!delproc(1, II)) continue;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

