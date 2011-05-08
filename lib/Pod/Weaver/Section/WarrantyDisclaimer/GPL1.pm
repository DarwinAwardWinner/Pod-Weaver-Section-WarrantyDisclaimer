use strict;
use warnings;

package Pod::Weaver::Section::WarrantyDisclaimer::GPL1;
use Moose;
# GPL1 text is identical to GPL2
extends "Pod::Weaver::Section::WarrantyDisclaimer::GPL2";
# ABSTRACT: Add the GPL1's DISCLAIMER OF WARRANTY section

1;

__END__

=pod

=head1 SYNOPSIS

In F<weaver.ini>, probably near the end:

    [WarrantyDisclaimer::GPL1]

=head1 OVERVIEW

This section plugin will add a B<DISCLAIMER OF WARRANTY> section to
your POD, containing the warranty text from the GNU General Public
License, Version 1. You should use this to weave your warranty section
if your code uses this license.

=cut
