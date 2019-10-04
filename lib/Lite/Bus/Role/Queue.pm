package Lite::Bus::Role::Queue;
use Moose::Role;
use 5.014;
use experimental qw(signatures);
requires qw( log );

has _memory => (
    is      => 'ro',
    isa     => 'ArrayRef',
    default => sub { [] },
);

sub enqueue ( $self, $data ) {
    $self->log->debug( sprintf "Enqueueing %s", $data );
    push @{$self->_memory}, $data;
}

sub dequeue( $self ) {
    my $data = pop @{$self->_memory};
	return undef unless $data;

    $self->log->debug( sprintf "Dequeueing %s", $data );
	return $data;
}

no Moose::Role;

1;

__END__

=head1 DESCRIPTION

A simple queue interface that defines enqueue/dequeue 

=head1 SYNOPSYS

=cut

