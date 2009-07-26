# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 3 };
use Commands::Guarded qw(:step verbose);

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

verbose(0);

my $var = 0;

eval {
   step shouldFail =>
     ensure { $var == 0 }
       using { $var = 0 }
	 sanity { $var == 1 }
	   ;
};

ok($@);

$var = 1;

eval {
   step shouldNotFail =>
     ensure { $var == 0 }
       using { $var = 0 }
	 sanity { 1 == 1 }
	   ;
};

ok(not $@);

$var = 0;

eval {
   step shouldFailOnSecondTry =>
     ensure { $var == 1 }
       using { $var = 1 }
	 sanity { $var == 0 }
};

ok($@);
