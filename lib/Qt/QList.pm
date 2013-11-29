package Qt::QList;
use parent 'Qt::QAbstractList';
 
use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = $class->SUPER::new(__PACKAGE__);
    return $self;
}


1;


