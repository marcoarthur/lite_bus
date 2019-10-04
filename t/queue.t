use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

# Test the queue controllers
my $t = Test::Mojo->new('Lite::Bus');
$t->get_ok('/queue')->status_is(200);

# enqueue
for my $msg ( 1..10 ) { 
	$t->post_ok('/enqueue.json' => form => { msg => $msg } )
	->status_is(200);
}

# dequeue
$t->get_ok('/queue')->status_is(200);

done_testing();
