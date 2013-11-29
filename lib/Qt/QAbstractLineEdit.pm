package Qt::QAbstractLineEdit;
use parent 'Qt::QAbstractWidget';
 
use strict;
use warnings;

use strict;
use Gtk2;

sub new {
    my $class = shift;
    my $child_class_name = shift;
    my $self = $class->SUPER::new('QAbstractLineEdit');
    $self->add_meta($child_class_name);
    return $self;
}

sub text {
    my $self = shift;
    return $self->gtkobj()->get_text;
}

sub setText {
    my $self = shift;
    my $t = shift;
    $t = '' if (!defined $t);
    $self->gtkobj()->set_text($t);
}


1;


