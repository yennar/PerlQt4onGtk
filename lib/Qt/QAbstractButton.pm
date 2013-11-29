package Qt::QAbstractButton;
use parent 'Qt::QAbstractWidget';
 
use strict;
use warnings;

sub new {
    my $class = shift;
    my $child_class_name = shift;
    my $self = $class->SUPER::new(__PACKAGE__);
    $self->add_meta($child_class_name);
    $self->register_signal_map(['clicked']);
    return $self;
}


1;


