requires 'Mojo::Base';
requires 'Mojo::File';
requires 'MojoX::Log::Log4perl';
requires 'Mojolicious::Commands';
requires 'Moose';
requires 'Moose::Role';
requires 'experimental';
requires 'perl', '5.014';

on test => sub {
    requires 'Test::Mojo';
    requires 'Test::More';
};


