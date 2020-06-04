package Sah::PSchema::perl::modname;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;

sub get_args {
    my $class = shift;

    return +{
        v => 1,
        ns_prefix => {
            schema => 'perl::modname*',
            default => '',
        },
    };
}

sub get_schema {
    my ($class, %args) = @_;

    return ['perl::modname', {
        'x.completion' => ['perl_modname' => {ns_prefix=>$args{ns_prefix}}],
    }];
}

1;
# ABSTRACT:

=head1 DESCRIPTION

B<EXPERIMENTAL.>
