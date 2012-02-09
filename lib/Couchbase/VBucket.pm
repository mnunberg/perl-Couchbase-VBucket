package Couchbase::VBucket;
our $VERSION;
BEGIN {
    require XSLoader;
    $VERSION = '0.01_1';
    XSLoader::load(__PACKAGE__, $VERSION);
}

use strict;
use warnings;


1;

__END__

=head1 NAME

Couchbase::VBucket - wrapper around libvbucket

=head2 DESCRIPTION

This is mainly used by some of the perl module's internals.
