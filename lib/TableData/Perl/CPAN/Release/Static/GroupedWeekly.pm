package TableData::Perl::CPAN::Release::Static::GroupedWeekly;

use 5.010001;
use strict;
use warnings;

use parent 'TableData::Munge::GroupRows';

use DateTime;

# AUTHORITY
# DATE
# DIST
# VERSION

my $re_date = qr/\A(\d\d\d\d)-(\d\d)-(\d\d)/;

sub new {
    require DateTime;

    my $self = shift;
    my $dt_sunday;
    my $dt_prev_sunday;
    my $prev_date; # to cache, for speed
    $self->SUPER::new(
        tabledata => 'Perl::CPAN::Release::Static',
        key => 'sunday',
        calc_key => sub {
            my ($rowh, $aoa) = @_;
            $rowh->{date} =~ $re_date or die;
            my $date = "$1-$2-$3";
            if (!$prev_date || $date ne $prev_date) {
                $dt_sunday = DateTime->new(year=>$1, month=>$2, day=>$3); $dt_sunday->subtract(days => $dt_sunday->day_of_week) unless $dt_sunday->day_of_week == 7;
                #print "D:sunday=".($dt_sunday->ymd)."\n";
                if ($dt_prev_sunday && DateTime->compare($dt_prev_sunday, $dt_sunday)) {
                    $dt_prev_sunday->add(days => 7);
                    while (DateTime->compare($dt_prev_sunday, $dt_sunday) < 0) {
                        push @$aoa, [$dt_prev_sunday->ymd, []];
                        $dt_prev_sunday->add(days => 7);
                    }
                }
                $dt_prev_sunday = $dt_sunday;
            }
            $prev_date = $date;
            $dt_sunday->ymd;
        },
    );
}

# STATS

1;
# ABSTRACT: CPAN releases (grouped weekly)

=for Pod::Coverage ^(.+)$

=head1 TABLEDATA NOTES

The data was filtered from L<TableData::Perl::CPAN::Release::Static>.
