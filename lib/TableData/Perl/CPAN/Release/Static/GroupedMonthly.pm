package TableData::Perl::CPAN::Release::Static::GroupedMonthly;

use 5.010001;
use strict;
use warnings;

use parent 'TableData::Munge::GroupRows';

use DateTime;

# AUTHORITY
# DATE
# DIST
# VERSION

my $re_period = qr/\A(\d\d\d\d)-(\d\d)/;

sub new {
    my $self = shift;
    my $prev_period;
    $self->SUPER::new(
        tabledata => 'Perl::CPAN::Release::Static',
        key => 'month',
        calc_key => sub {
            my ($rowh, $aoa) = @_;
            $rowh->{date} =~ $re_period or die;
            my $period = "$1-$2";
            if ($prev_period && $prev_period ne $period) {
                $prev_period =~ $re_period or die;
                my $dt = DateTime->new(year=>$1, month=>$2, day=>1);
                $dt->add(months => 1);
                $period =~ $re_period or die;
                my $dt_period = DateTime->new(year=>$1, month=>$2, day=>1);
                while (DateTime->compare($dt, $dt_period) < 0) {
                    # close date gaps with rows of empty groups
                    push @$aoa, [$dt->strftime("%Y-%m"), []];
                    $dt->add(months => 1);
                }
            }
            $prev_period = $period;
            $period;
        },
    );
}

# STATS

1;
# ABSTRACT: CPAN releases (grouped monthly)

=for Pod::Coverage ^(.+)$

=head1 TABLEDATA NOTES

The data was filtered from L<TableData::Perl::CPAN::Release::Static>.
