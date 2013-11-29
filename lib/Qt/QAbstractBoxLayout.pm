package Qt::QAbstractBoxLayout;
use parent 'Qt::QAbstractLayout','Qt::QAbstractList';


use strict;
use warnings;

use strict;
use Gtk2;
use Glib qw(TRUE FALSE);


=pod

=head1 B<Qt::QAbstractBoxLayout>

=head2 DESCRIPTION

Inherits L<QAbstractLayout>

This module is the abstract object used for box layouts.

=head2 SYNOPSIS

    $layout->addWidget($some_widget);
    
=head2 METHODS

=head3 new($child_class_name)

Only for subclass.

    package MyLayout;
    use parent 'Qt::QAbstractBoxLayout';
    
    sub new {
        my $class = shift;
        my $self = $class->SUPER::new('MyLayout');
        return $self;
    }

=cut

sub new {
    my $class = shift;
    my $child_class_name = shift;
    my $self = $class->SUPER::new('QAbstractBoxLayout');
    $self->add_meta($child_class_name);
    $self->{'direction'} = 'X';
    $self->init();
    return $self;
}

=pod

=head3 addWidget($widget)

Add the C<$widget> to layout.

=cut

sub addWidget {
    my $self = shift;
    my $widget = shift;
    $self->append($widget);
}

sub insertWidget {
    my $self = shift;
    my $pos = shift;
    my $widget = shift;
    $self->insert($pos,$widget);
}

=pod

=head3 pack_widget()

Internal function.

The QWidget::setLayout will call this function to create a layout.

=cut

sub pack_widget {
    my $self = shift;
    my $size = $self->size();
    my $obj = $self->gtkobj();
    foreach (@{$self->list()}) {
        my $expand = FALSE;
        $_ = $self->iter($_);
        #print STDERR "pack $_\n";
        if ($_->is('QTextEdit')) {
            $expand = TRUE;
        }
        if (($_->is('QLineEdit') || $_->is('QAbstractButton')) && $self->{'direction'} eq 'H') {
            $expand = TRUE;
        }
        if ($size == 0) {
            $obj->pack_end($_->gtkobj(),FALSE,$expand,2);
        } else {
            $obj->pack_start($_->gtkobj(),FALSE,$expand,2);
        }
        $self->set_packed($_->gtkobj());
        $size--;
    }
}

1;


