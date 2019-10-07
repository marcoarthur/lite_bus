package Lite::Bus::Controller::Queue;
use 5.014;
use Mojo::Base 'Mojolicious::Controller';
use experimental qw(signatures);
use Data::Dumper;

sub enqueue( $self ) {
    my $data = $self->req->body;
    $self->q->enqueue($data);
    $self->render( text => $data );
}

sub list ( $self ) {
    $self->render( queue => $self->q );
}

sub dequeue( $self ) {
	my $data = $self->q->dequeue;
	$self->render( json => $data );
}

1;

__END__

=head1 DESCRIPTION

Controller for Queue using different backends.

=head1 SYNOPSYS

=cut

