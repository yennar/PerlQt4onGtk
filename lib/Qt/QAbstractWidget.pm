package Qt::QAbstractWidget;
use parent 'Qt::QAbstractObject';

use strict;
use warnings;

use strict;
use Gtk2;

=pod

=head1 B<Qt::QAbstractWidget>

=head2 DESCRIPTION

This module is the foundation class of PerlQt4onGtk.
As an abstract class, this class is only for subclassing.

=head2 SYNOPSIS

    package MyWidget;
    use parent 'Qt::QAbstractWidget';
    
    sub new {
        my $class = shift;
        my $self = $class->SUPER::new(__PACKAGE__);
        return $self;
    }

=head2 METHODS


=head3 new($child_class_name)

returns a new QAbstractWidget

=cut
sub new {
    my $class = shift;
    my $child_class_name = shift;
    my $self = $class->SUPER::new(__PACKAGE__);
    $self->add_meta($child_class_name);    
    return $self;    
}


=pod

=head3 attach($gtk_object),set_gtkobj($gtk_object)

attach a gtk_object to the widget.

example:

    package Qt::QPushButton;
    use parent 'Qt::QAbstractButton';
     
    use strict;
    use Gtk2;
    
    sub new {
        my $class = shift;
        my $text = shift;    
        my $self =  $class->SUPER::new(__PACKAGE__);
        $self->attach(Gtk2::Button->new($text));   
        return $self;    
    }

=cut

sub attach {
    my $self = shift;
    my $attach = shift;
    $self->{'_'} = $attach;
}

sub set_gtkobj {
    my $self = shift;
    my $attach = shift;
    $self->attach($attach);
}

=pod

=head3 gtkobj()

returns the gtk_object attached to the widget.

=cut
sub gtkobj {
    my $self = shift;
    return $self->{'_'};
}

=pod

=head3 show()

displays the widget to the desktop.

Once the show method is called, the widget becomes a individual top window.

Currently PerlQt4onGtk only supports one top window.

=cut

sub show {
    my $self = shift;
    my $gtkobj = $self->gtkobj();
    my $window = Gtk2::Window->new ('GTK_WINDOW_TOPLEVEL');
    $window->signal_connect (delete_event => sub { Gtk2->main_quit });
    $window->add ($gtkobj) if (defined $gtkobj);
    $window->set_position ('GTK_WIN_POS_CENTER');
    $gtkobj->show_all;
    $window->show_all;
}



1;