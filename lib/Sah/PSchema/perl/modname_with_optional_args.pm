package Sah::PSchema::perl::modname_with_optional_args;

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
            req_one => [qw/ns_prefix ns_prefixes/],
        },
    };
}

sub get_schema {
    # we follow Sah::Schema::perl::modname_with_optional_args
    require Regexp::Pattern::Perl::Module;

    my ($class, $args, $merge) = @_;


    my $schema_str = [str => {
        match => '\\A(?:' . $Regexp::Pattern::Perl::Module::RE{perl_modname_with_optional_args}{pat} . ')\\z',
        'x.perl.coerce_rules' => [
            ['From_str::normalize_perl_modname', {
                ($args->{ns_prefixes} ? (ns_prefixes => $args->{ns_prefixes}) : (ns_prefix => $args->{ns_prefix})),
            }],
        ],
        'x.completion' => ['perl_modname', {
            ($args->{ns_prefixes} ? (ns_prefixes => $args->{ns_prefixes}) : (ns_prefix => $args->{ns_prefix})),
            recurse=>$args->{complete_recurse},
            recurse_matching=>'all-at-once',
        }],
    }];

    my $schema_ary = [array_from_json => {
        min_len => 1,
        max_len => 2,
        elems => [
            $schema_str,
            ["any", {
                req=>1,
                of=>[
                    ["array",{req=>1}],
                    ["hash",{req=>1}]],
            }],
        ],
    }];

    return ["any", {
        of => [
            $schema_ary,
            $schema_str,
        ],

        'x.completion' => ['perl_modname' => {
            ($args->{ns_prefixes} ? (ns_prefixes => $args->{ns_prefixes}) : (ns_prefix => $args->{ns_prefix})),
            recurse=>$args->{complete_recurse},
            recurse_matching=>'all-at-once',
        }],

        %{ $merge || {} },
    }, {}];
}

1;
# ABSTRACT: Perl module name with optional args (parameterized)

=for Pod::Coverage ^(.+)$

=head1 DESCRIPTION

B<EXPERIMENTAL.>


=head1 SEE ALSO

L<Sah::Schema::perl::modname_with_optional_args>
