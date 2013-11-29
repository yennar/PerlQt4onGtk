package Qt::QAction;
use parent 'Qt::QAbstractObject';
 
use strict;
use warnings;

=pod

=head1 B<Qt::QAction>

=head2 DESCRIPTION

The QAction class provides an abstract user interface action that can be inserted into widgets.
Actions can be added to menus via QMenu::addAction

=head2 SYNOPSIS

Create QAction with title and slot:

    my $action = QAction ('Save',sub {some_save_operations});
    
Or with title and then connects to some slot later:

    my $action = QAction ('Save');
    $action->{triggered}->connect(\&sub_save);

=cut


sub new {
    my $class = shift;
    my $text = shift;
    my $checkable = shift;
    my $self = $class->SUPER::new(__PACKAGE__);
    
    $text = '' if (!defined $text);
    $checkable = 0 if (!defined $checkable);
    
    $self->set_properity('checkable',$checkable);
    $self->set_properity('checked',0);
    $self->set_properity('enabled',1);
    $self->set_properity('shortcut',0);
    $self->set_properity('statusTip',0);
    $self->set_properity('visible',1);
    $self->set_properity('text',$text);            
    
    $self->register_signal_map(['triggered','toggled']);
    
    #Qt donot have a MenuItem.
    #The menu item will embedded in the action
    

    if ($text ne '') {
        my @mapped = map { ($_ eq 'gtk-' . lc($text)) ? ($_) : () } Gtk2::Stock->list_ids();
        if (scalar (@mapped)) {
            $self->{menu} = Gtk2::ImageMenuItem->new_from_stock ($mapped[0], undef);
        }
    }
    
    if ( !defined $self->{menu}) {
        if ($checkable) {
            $self->{menu} = Gtk2::CheckMenuItem->new($self->properity('text'));
        } else {
            $self->{menu} = Gtk2::MenuItem->new($self->properity('text'));
        }
    }
    
    
    $self->{menu}->signal_connect('activate' => sub {$self->{triggered}->emit()});
    if ($checkable) {
        $self->{menu}->signal_connect('toggled' => sub {$self->{toggled}->emit($self->{menu}->get_active)});
    }
    return $self;
}

sub menu {
    my $self = shift;
    return $self->{menu};
}

1;


