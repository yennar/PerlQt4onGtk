package Qt::QMenuBar;
use parent 'Qt::QAbstractWidget','Qt::QAbstractList';
 
use strict;
use warnings;
use Gtk2;


sub new {
    my $class = shift;
    my $self = $class->SUPER::new(__PACKAGE__);
    $self->attach(Gtk2::MenuBar->new);
    $self->init();
    return $self;
}

sub addMenu {
    my $self = shift;
    my $menu_item = shift;
    
    return if (!defined $menu_item);
    
    if (ref($menu_item) eq '') {
    } else {
        if ($menu_item->is('QMenu')) {
            #print $menu_item->gtkobj();
            my $gtk_menu_item = Gtk2::MenuItem->new($menu_item->properity('text'));
            $gtk_menu_item -> set_submenu($menu_item->gtkobj());
            $self->gtkobj()->append($gtk_menu_item);
        }
    }
    
}


1;


