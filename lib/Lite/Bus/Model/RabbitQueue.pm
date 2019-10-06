package Lite::Bus::Model::RabbitQueue;
use Moose;
use 5.014;
use experimental qw(signatures);
use Net::AMQP::RabbitMQ;
use Try::Tiny;

has _queue => (
    is      => 'ro',
    isa     => 'Net::AMQP::RabbitMQ',
    lazy    => 1,
    builder => '_build_queue',
);

has config => (
    is       => 'ro',
    isa      => 'HashRef',
    required => 1,
);

has _q_name => (
    is       => 'ro',
    isa      => 'Str',
    default  => 'lite_queue',
    required => 1,
);

has _channel => (
    is       => 'ro',
    isa      => 'Int',
    default  => 1,
    required => 1,
);

has _host => (
    is      => 'ro',
    isa     => 'Str',
    default => 'localhost',
);

has log => (
    is       => 'ro',
    required => 1,
);

with qw( Lite::Bus::Role::Queue );

sub _build_queue( $self ) {
    my $mq = Net::AMQP::RabbitMQ->new();

    try {
        $mq->connect( $self->_host, $self->config );
        $mq->channel_open( $self->_channel );
        $mq->queue_declare( $self->_channel, $self->_q_name );
    } catch {
        my $e = shift;
        die "Error can't connect " . $e->message;
    };

    return $mq;
}

sub enqueue ( $self, $data ) {
    $self->log->debug( sprintf "Enqueing %s", $data );
    $self->_queue->publish( $self->_channel, $self->_q_name, $data );
}

sub dequeue( $self ) {
    my $data = $self->_queue->get( $self->_channel, $self->_q_name );
    return undef unless $data;
    $self->log->debug( sprintf "Dequeing %s", $data );
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 DESCRIPTION

An async queue using the famous rabbit mq

=head1 SYNOPSYS

=cut

