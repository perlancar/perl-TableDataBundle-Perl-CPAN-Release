package TableData::Perl::CPAN::Release::Static::GroupedDaily;

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
    my $self = shift;
    my $prev_date;
    $self->SUPER::new(
        tabledata => 'Perl::CPAN::Release::Static',
        key => 'date',
        calc_key => sub {
            my ($rowh, $aoa) = @_;
            $rowh->{date} =~ $re_date or die;
            my $date = "$1-$2-$3";
            if ($prev_date && $prev_date ne $date) {
                $prev_date =~ $re_date or die;
                my $dt = DateTime->new(year=>$1, month=>$2, day=>$3);
                $dt->add(days => 1);
                $date =~ $re_date or die;
                my $dt_date = DateTime->new(year=>$1, month=>$2, day=>$3);
                while (DateTime->compare($dt, $dt_date) < 0) {
                    # close date gaps with rows of empty groups
                    push @$aoa, [$dt->ymd, []];
                    $dt->add(days => 1);
                }
            }
            $prev_date = $date;
            $date;
        },
    );
}

# STATS

1;
# ABSTRACT: CPAN releases (grouped daily)

=for Pod::Coverage ^(.+)$

=head1 TABLEDATA NOTES

The data was filtered from L<TableData::Perl::CPAN::Release::Static>.
