use strict;
use warnings;

package Pod::Weaver::Section::WarrantyDisclaimer::Custom;
use Moose;
extends "Pod::Weaver::Section::WarrantyDisclaimer";
# ABSTRACT: Specify a custom warranty section

=for Pod::Coverage mvp_multivalue_args

sub mvp_multivalue_args { qw( text ) }

=attr title

Specify your own section title.

=cut

has 'title' => (
    is => 'ro',
    isa => 'Str',
    default => '',
);

=attr text

Specify your own warranty as text.

Default: none

Since you can't put newlines in weaver.ini you can specify this option
multiple times:

  text = My Default Foo Warranty
  text = Second line of warranty
  text = ...
  text = Last line of warranty

=cut

has 'text' => (
    is => 'ro',
    isa => 'ArrayRef[Str]',
    default => sub { [] },
);

around warranty_section_title => sub {
    my $orig = shift;
    my $self = shift;
    # Use the standard title if not specified.
    return $self->title || $self->$orig(@_);
};

around warranty_text => sub {
    my $orig = shift;
    my $self = shift;
    # If no text is specified, use the default
    if (@{ $self->text}) {
        return join( "\n", @{ $self->text } );
    }
    else {
        return $self->$orig(@_);
    }
};

1;

__END__

=pod

=head1 SYNOPSIS

In F<weaver.ini>, probably near the end:

    [WarrantyDisclaimer::Custom]
    title = "WARRANTY"
    text = "First line of warranty text"
    text = "Second line of text"

=head1 OVERVIEW

This section plugin will add a warranty section to your POD, with a
custom title and text. You can use this to add your own license's
warranty to your code if you are using a license for which a warranty
moduel is not already available.

If not specified, the default title and text are the same as if you
just put `[WarrantyDisclaimer]` in weaver.ini.

=cut
