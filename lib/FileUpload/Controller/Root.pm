package FileUpload::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

FileUpload::Controller::Root - Root Controller for FileUpload

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    open(my $fh, '<:raw', './root/index.html');
    $c->response->body( $fh );
    $fh = undef;
}

sub upload : Local {
    my ( $self, $c ) = @_;
    
    my $response = {
      error => -1,
      message => 'File upload failed!'
    };
    
    for my $field ( $c->req->upload ) {
        my $upload   = $c->req->upload($field);
        my $filename = $upload->filename;
        my $target   = "/tmp/$filename";

        unless ( $upload->link_to($target) || $upload->copy_to($target) ) {
          die( "Failed to copy '$filename' to '$target': $!" );
        }
        # I get that this is done for ever file, just kept it simple...
        $response = {
          OK => 1,
          message => 'Copied files to /tmp/'
        }        
    }

    $c->stash->{status} = $response;
    
}


=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {
  my ( $self, $c ) = @_;
}


=head1 AUTHOR

Daniel Maldonado

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
