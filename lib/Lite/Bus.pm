package Lite::Bus;
use Mojo::Base 'Mojolicious';
use MojoX::Log::Log4perl;
use 5.014;
use Mojo::Loader qw( load_class );
use experimental qw(signatures);

sub init_helpers( $self ) {
    my $logger = $self->log;

	# Load queue model
    my $q_model  = $self->config->{queue};
    if ( my $e = load_class $q_model ) {
        die ref $e ? "Exception: $e" : 'Not found!';
    }
    my $q_config = $self->config->{queue_config} || {};

    $self->helper(
        q => sub {
            state $q = $q_model->new(
                log    => $logger,
                config => $q_config,
            );
        }
    );
}

# This method will run once at server start
sub startup {
    my $self = shift;

    # Load configuration from hash returned by config file
    my $config = $self->plugin('Config');

    # Load Log4perl
    # $self->log( MojoX::Log::Log4perl->new );

    # Configure the application
    $self->secrets( $config->{secrets} );

    # Set helpers
    $self->init_helpers;

    # Router
    my $r = $self->routes;

    # Normal route to controller
    $r->get('/')->to('example#welcome');
    $r->get('/queue')->to('queue#list');
    $r->post('/enqueue')->to('queue#enqueue');
}

1;
