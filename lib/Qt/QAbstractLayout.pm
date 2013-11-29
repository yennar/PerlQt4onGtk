package Qt::QAbstractLayout;
use parent 'Qt::QAbstractWidget';
use Qt::QList;

use strict;
use warnings;

use strict;
use Gtk2;

sub new {
    my $class = shift;
    my $child_class_name = shift;
    my $self = $class->SUPER::new(__PACKAGE__);
    $self->add_meta($child_class_name);
    $self->{'spacing'} = 1;
    $self->{'packed_widgets'} = Qt::QList->new();
    return $self;
}

sub clear {
    my $self = shift;
    my $obj = $self->gtkobj();
    foreach (@{$self->{'packed_widgets'}->list()}) {
        my $o = $self->{'packed_widgets'}->iter($_);
        $obj->remove($o);
        $self->{'packed_widgets'}->remove($o);
    }    
}

sub set_packed {
    my $self = shift;
    my $w = shift;
    $self->{'packed_widgets'}->append($w);
}

1;


