package ## no critic: Modules::RequireFilenameMatchesPackage
    # hide from PAUSE
    TableDataRole::Perl::CPAN::Release::Static;

use 5.010001;
use strict;
use warnings;

use Role::Tiny;
with 'TableDataRole::Source::CSVInFiles';

around new => sub {
    require DateTime;
    require File::ShareDir;

    my $orig = shift;

    my $now = DateTime->now;
    my $cur_year = $now->year;

    my @filenames;
    for my $year (1995..$cur_year) {
        my $filename = File::ShareDir::dist_file(
            ($year < 2022 ? 'TableDataBundle-Perl-CPAN-Release-Static-Older' : "TableData-Perl-CPAN-Release-Static-$year"),
            "$year.csv");
        push @filenames, $filename;
    }
    $orig->(@_, filenames=>\@filenames);
};

package TableData::Perl::CPAN::Release::Static;

use 5.010001;
use strict;
use warnings;

use Role::Tiny::With;

# AUTHORITY
# DATE
# DIST
# VERSION

with 'TableDataRole::Perl::CPAN::Release::Static';

# STATS

1;
# ABSTRACT: CPAN releases (from oldest to newest)

=head1 TABLEDATA NOTES

The data was retrieved from MetaCPAN.

The C<status> column is the status of the release when the row was retrieved from
MetaCPAN. It is probably not current, so do not use it.
