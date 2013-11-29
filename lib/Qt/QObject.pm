package Qt::QObject;
use parent 'Qt::QAbstractObject';
 
use strict;
use warnings;

sub new {
    my $class = shift;
    my $self = $class->SUPER::new(__PACKAGE__);
    return $self;
}


1;


