package Lite::Bus;
use Mojo::Base 'Mojolicious';
use MojoX::Log::Log4perl;
use 5.014;
use Lite::Bus::Model::Queue;
use experimental qw(signatures);

sub init_helpers( $self ) {
	my $logger = $self->log;

	$self->helper( 
		q => sub { state $q = Lite::Bus::Model::Queue->new( log => $logger) ; }
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
  $self->secrets($config->{secrets});

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
