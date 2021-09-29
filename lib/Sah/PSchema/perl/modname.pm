package Sah::PSchema::perl::modname;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    my $class = shift;

    return +{
        v => 1,
        args => {
            ns_prefix => {
                schema => 'perl::modname*',
                default => '',
            },
            ns_prefixes => {
                schema => 'perl::modname*',
            },
            complete_recurse => {
                summary => 'Whether completion should recurse',
                schema => 'bool*',
            },
        },
        args_rels => {
            choose_one => [qw/ns_prefix ns_prefixes/],
        },
    };
}

sub get_schema {
    require Sah::Schema::perl::modname; # for scan_prereqs

    my ($class, $args, $merge) = @_;

    return ['perl::modname', {
        'x.completion' => ['perl_modname' => {
            ($args->{ns_prefixes} ? (ns_prefixes => $args->{ns_prefixes}) : (ns_prefix => $args->{ns_prefix})),
            recurse=>$args->{complete_recurse},
            recurse_matching=>'all-at-once',
        }],
        %{ $merge || {} },
    }, {}];
}

1;
# ABSTRACT: Perl module name (parameterized)

=for Pod::Coverage ^(.+)$

=head1 DESCRIPTION

B<EXPERIMENTAL.>


=head1 SEE ALSO

L<Sah::Schema::perl::modname>
