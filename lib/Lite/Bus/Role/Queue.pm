package Lite::Bus::Role::Queue;
use Moose::Role;
use 5.014;
use experimental qw(signatures);
requires qw( log enqueue dequeue config );

no Moose::Role;

1;

__END__

=head1 DESCRIPTION

A simple queue interface that defines enqueue/dequeue 

=head1 SYNOPSYS

=cut

