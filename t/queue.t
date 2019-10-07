use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

# Test the queue controllers
my $t = Test::Mojo->new('Lite::Bus');

# enqueue
for my $msg ( 1..10 ) { 
	$t->post_ok('/enqueue.json' => json => { msg => $msg } )
	->status_is(200)
	->json_is({ msg => $msg});
}

# dequeue one element
$t->get_ok('/dequeue')->status_is(200);
note $t->tx->res->body;

# consume all queue: dequeue all
$t->get_ok('/queue')->status_is(200);

done_testing();
