package CGI::Untaint::date;

use strict;
use base 'CGI::Untaint::printable';
use Date::Manip;
use Date::Simple;

use vars qw/$VERSION/;
$VERSION = '0.01';

sub is_valid {
  my $self = shift;
  Date_Init('DateFormat=UK');
  my $date = ParseDate($self->value) or return;
  my @date = unpack "A4A2A2", $date;
  my $ds = eval { Date::Simple->new(@date) } or return;
  $self->value($ds);
  return $ds;
}


=head1 NAME

CGI::Untaint::date - validate a date

=head1 SYNOPSIS

  use CGI::Untaint;
  my $handler = CGI::Untaint->new($q->Vars);

  my $date = $handler->extract(-as_date => 'date');

=head1 DESCRIPTION

This Input Handler verifies that it is dealing with a reasonable
date. Reasonably means anything that Date::Manip thinks is
sensible, so you could use any of (for example):
  "December 12, 2001"
  "12th December, 2001"
  "2001-12-12"
  "next Tuesday"
  "third Wednesday in March"

L<Date::Manip> for much more information here.

The resulting date will be a Date::Simple object. 
L<Date::Simple> for more information on this.

=head1 NOTE

Ambiguous dates of the format 08/09/2001 will be treated
as UK style (i.e. 9th August, rather than 8th September).

=head1 SEE ALSO

L<Date::Simple>. L<Date::Manip>.

=head1 AUTHOR

Tony Bowden, E<lt>kasei@tmtm.comE<gt>. 

=head1 COPYRIGHT

Copyright (C) 2001 Tony Bowden. All rights reserved.

This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
