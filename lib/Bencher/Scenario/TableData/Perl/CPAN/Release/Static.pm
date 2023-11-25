package Bencher::Scenario::TableData::Perl::CPAN::Release::Static;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

our $scenario = {
    summary => 'Benchmark loading TableData::Perl::CPAN::Release::Static',
    participants => [
        {
            module=>'TableData::Perl::CPAN::Release::Static',
            code_template => 'TableData::Perl::CPAN::Release::Static->new->each_row_hashref(sub {1})',
        },
    ],
    precision => 1,
};

1;
# ABSTRACT:
