package TableData::CPAN::Release::Static::FromNewest;

use 5.010001;
use strict;
use warnings;

use parent 'TableData::Munge::Concat';

# AUTHORITY
# DATE
# DIST
# VERSION

sub new {
    my $self = shift;
    my @tabledatalist;
    for my $year (reverse 1995..2021) {
        push @tabledatalist, "Munge::Reverse=tabledata,CPAN::Release::Static::$year";
    }
    $self->SUPER::new(tabledatalist => \@tabledatalist);
}

# STATS

1;
# ABSTRACT: CPAN releases (from newest to oldest)

=for Pod::Coverage ^(.+)$

=head1 TABLEDATA NOTES

The data was retrieved from MetaCPAN.

The C<status> column is the status of the release when the row was retrieved
from MetaCPAN. It is probably not current, so do not use it.
