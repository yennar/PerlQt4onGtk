package Qt::QMenu;
use parent 'Qt::QAbstractWidget','Qt::QAbstractList';
use Qt::QAction;

use strict;
use warnings;
use Gtk2;


sub new {
    my $class = shift;
    my $text = shift;
    my $self = $class->SUPER::new(__PACKAGE__);
    $self->attach(Gtk2::Menu->new);
    $self->set_properity('text',$text);
    return $self;
}

sub addAction {
    my $self = shift;
    my $parameter1 = shift;
    my $parameter2 = shift;
    
    
    return undef if (!defined $parameter1);
    my $action = undef;
    #text only
    
    if (ref($parameter1) eq '') {
        #QAction *	addAction ( const QString & text )
        $action = Qt::QAction->new($parameter1);
        if (defined $parameter2 && ref($parameter2) eq 'CODE') {
            #QAction *	addAction ( const QString & text, const QObject * receiver, const char * member, const QKeySequence & shortcut = 0 )
            $action->{triggered}->connect($parameter2,$action);
        }
    } elsif ($parameter1->is('QAction')) {
        $action = $parameter1;
    }
    
    $self->gtkobj()->append($action->menu());
    $self->append($action);
    
    return $action;
}


1;


