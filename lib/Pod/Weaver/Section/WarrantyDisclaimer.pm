use strict;
use warnings;

package Pod::Weaver::Section::WarrantyDisclaimer;

use Moose;
with 'Pod::Weaver::Role::Section';
# ABSTRACT: Add a standard DISCLAIMER OF WARRANTY section (for your Perl module)

use Moose::Autobox;

use Pod::Elemental::Element::Pod5::Ordinary;
use Pod::Elemental::Element::Nested;

=for Pod::Coverage weave_section

=cut

sub weave_section {
    my ($self, $document) = @_;

    my $content = <<'EOF';
BECAUSE THIS SOFTWARE IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE SOFTWARE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT
WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER
PARTIES PROVIDE THE SOFTWARE "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE
SOFTWARE IS WITH YOU. SHOULD THE SOFTWARE PROVE DEFECTIVE, YOU ASSUME
THE COST OF ALL NECESSARY SERVICING, REPAIR, OR CORRECTION.

IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
REDISTRIBUTE THE SOFTWARE AS PERMITTED BY THE ABOVE LICENCE, BE LIABLE
TO YOU FOR DAMAGES, INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR INABILITY TO USE THE
SOFTWARE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA BEING
RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD PARTIES OR A
FAILURE OF THE SOFTWARE TO OPERATE WITH ANY OTHER SOFTWARE), EVEN IF
SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH
DAMAGES.
EOF

    my $warranty_para = Pod::Elemental::Element::Nested->new({
        command  => 'head1',
        content  => 'DISCLAIMER OF WARRANTY',
        children => [
            Pod::Elemental::Element::Pod5::Ordinary->new({ content => $content }),
        ],
    });

    $document->children->push($warranty_para);
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
