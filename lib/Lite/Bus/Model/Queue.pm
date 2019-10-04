package Lite::Bus::Model::Queue;
use Moose;
use 5.014;
use experimental qw(signatures);

has log => (
	is => 'ro',
	required => 1,
);

has _memory => (
    is      => 'ro',
    isa     => 'ArrayRef',
    default => sub { [] },
);

with qw(Lite::Bus::Role::Queue);

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

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 DESCRIPTION

=head1 SYNOPSYS

=cut

