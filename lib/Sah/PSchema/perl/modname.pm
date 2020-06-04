package Sah::PSchema::perl::modname;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;

sub meta {
    my $class = shift;

    return +{
        v => 1,
        args => {
            ns_prefix => {
                schema => 'perl::modname*',
                default => '',
            },
        },
    };
}

sub get_schema {
    my ($class, $args, $merge) = @_;

    return ['perl::modname', {
        'x.completion' => ['perl_modname' => {ns_prefix=>$args->{ns_prefix}}],
        %{ $merge || {} },
    }];
}

1;
# ABSTRACT: Perl module name (parameterized)

=for Pod::Coverage ^(.+)$

=head1 DESCRIPTION

B<EXPERIMENTAL.>


=head1 SEE ALSO

L<Sah::Schema::perl::modname>
