package Sah::PSchema::perl::modname_with_optional_args;

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
        },
    };
}

sub get_schema {
    return ["perl::modname_with_optional_prefix" => {
        'x.perl.coerce_rules' => [
            ['From_str::normalize_perl_modname' => {ns_prefix=>$args->{ns_prefix}}],
        ],

        'x.completion' => ['perl_modname' => {ns_prefix=>$args->{ns_prefix}}],
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
