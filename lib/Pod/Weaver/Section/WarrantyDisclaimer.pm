use strict;
use warnings;

package Pod::Weaver::Section::WarrantyDisclaimer;

use Moose;
with 'Pod::Weaver::Role::Section';
# ABSTRACT: Add a standard DISCLAIMER OF WARRANTY section (for your Perl module)

use Moose::Autobox;

use Pod::Elemental::Element::Pod5::Ordinary;
use Pod::Elemental::Element::Nested;

sub mvp_multivalue_args { qw( custom_warranty ) }

=for Pod::Coverage weave_section mvp_multivalue_args

=cut

=attr warranty

Specify where to get the warranty from.

Known versions: GPL_1, GPL_2, GPL_3

Default: GPL_1

Note: If you want another version, please send a patch to us! In the meantime you can use L</custom_warranty>.

=cut

{
    use Moose::Util::TypeConstraints;

    has 'warranty' => (
        is => 'ro',
        isa => enum( [ qw( GPL_1 GPL_2 GPL_3 ) ] ),
        default => 'GPL_1',
    );
}

=attr custom_warranty

Specify your own warranty as text. Overrides the L</warranty> option.

Default: none

NOTE: Since you can't put newlines in weaver.ini you can specify this option multiple times.

  warranty = My Default Foo Warranty
  warranty = Second line of warranty
  warranty = ...
  warranty = Last line of warranty

=cut

has 'custom_warranty' => (
    is => 'ro',
    isa => 'ArrayRef[Str]',
    default => sub { [ ] },
);

sub weave_section {
    my ($self, $document) = @_;

    my $content;
    if ( scalar @{ $self->custom_warranty } ) {
        $content = join( "\n", @{ $self->custom_warranty } );
    } else {
        my $warranty = '_warranty_' . lc( $self->warranty );
        $content = $self->$warranty();
    }

    my $warranty_para = Pod::Elemental::Element::Nested->new({
        command  => 'head1',
        content  => 'DISCLAIMER OF WARRANTY',
        children => [
            Pod::Elemental::Element::Pod5::Ordinary->new({ content => $content }),
        ],
    });

    $document->children->push($warranty_para);
}

# GNU General Public License v1 ( http://www.gnu.org/licenses/gpl-1.0.txt )
sub _warranty_gpl_1 {
    return <<'EOF';
BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
REPAIR OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
POSSIBILITY OF SUCH DAMAGES.
EOF
}

# GNU General Public License v2 ( http://www.gnu.org/licenses/gpl-2.0.txt )
sub _warranty_gpl_2 {
    # Exactly the same as gpl_1 hah
    return shift->_warranty_gpl_1;
}

# GNU General Public License v3 ( http://www.gnu.org/licenses/gpl-3.0.txt )
sub _warranty_gpl_3 {
    return <<'EOF';
THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY
APPLICABLE LAW.  EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT
HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY
OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM
IS WITH YOU.  SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF
ALL NECESSARY SERVICING, REPAIR OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MODIFIES AND/OR CONVEYS
THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY
GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE
USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF
DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD
PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS),
EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.
EOF
}

1;

__END__
=pod

=head1 SYNOPSIS

In F<weaver.ini>, probably near the end:

    [WarrantyDisclaimer]

=head1 OVERVIEW

This section plugin will add the standard B<DISCLAIMER OF WARRANTY>
section to your POD. See the bottom of this module's documentation for
the content of this section.

=cut
