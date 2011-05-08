use strict;
use warnings;

package Pod::Weaver::Section::WarrantyDisclaimer::Artistic;
use Moose;
extends "Pod::Weaver::Section::WarrantyDisclaimer";
# ABSTRACT: Add the Artistic License's DISCLAIMER OF WARRANTY section

sub warranty_section_title {
    return 'DISCLAIMER OF WARRANTY';
}

sub warranty_text {
    return <<'EOF';
THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
EOF
}

1;

__END__

=pod

=head1 SYNOPSIS

In F<weaver.ini>, probably near the end:

    [WarrantyDisclaimer::Artistic]

=head1 OVERVIEW

This section plugin will add a B<DISCLAIMER OF WARRANTY> section to
your POD, containing the warranty text from the Perl "Artistic
License." You should use this to weave your warranty section if your
code uses this license.

=cut
