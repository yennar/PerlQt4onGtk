package Qt::QAbstractObject;
use Qt::signal;

use strict;
use warnings;

=pod

=head1 B<Qt::QAbstractObject>

=head2 DESCRIPTION

This module is the foundation class of PerlQt4onGtk.
As an abstract class, this class is only for subclassing.

=head2 SYNOPSIS

    package MyObject;
    use parent 'Qt::QAbstractObject';
    
    sub new {
        my $class = shift;
        my $self = $class->SUPER::new(__PACKAGE__);
        return $self;
    }

=head2 METHODS


=head3 new($child_class_name)

When subclassing QAbstractObject, specify the subclass name as C<$child_class_name>.
It is a good idea to use C<__PACKAGE__>. The C<$child_class_name> will added to the B<meta object list> of this object in order to
identify the I<type> of this widget.

The reason why we not using the default perl C<ref> is that C<ref> cannot recognize the class tree. And with the new meta mechanism,
it is easy to find out what one object is and also what the base class of one object is. 

=cut
sub new {
    my $class = shift;
    my $child_class_name = shift;


    if (!defined $child_class_name) {
        $child_class_name = 'QAbstractObject';
    }
    
    $child_class_name =~ s/.*:://g;
    
    my $this_class_name = 'QAbstractObject';    
    my $meta_type_list = {};
    $meta_type_list->{$this_class_name} = 1;
    $meta_type_list->{$child_class_name} = 1;
    
    my $self = {'this_class_name' => $this_class_name, 'meta_type_list' => $meta_type_list ,'signal_object_list' => {},'properities' => {} ,'id' => undef};
    bless $self, $class;
    return $self;    
}

sub _set_id {
    my $self = shift;
    my $id = shift;
    if (!defined $self->{id}) {
        $self->{id} = $id;
    }
}

sub class_name {
    my $self = shift;
    return $self->{'this_class_name'};
}

=pod 

=head3 is($class_name)

returns true if this widget is a class C<$class_name>

example:

    my $hello = QPushButton("Hello world!");
    print $hello->is('QPushButton'),"\n"; #return 1
    print $hello->is('QAbstractWidget'),"\n"; #return 1
    print $hello->is('QLineEdit'),"\n"; #return 0

=cut

sub is {
    my $self = shift;
    my $class_name = shift;
    return 1 if (defined $self->{'meta_type_list'}->{$class_name});
    return 0;
}

=pod 

=head3 add_meta($class_name)

add the class name C<$class_name> to the meta name list of this widget.

example:

    my $hello = QPushButton("Hello world!");
    print $hello->is('foo'),"\n"; #return 0
    $hello->add_meta('foo');
    print $hello->is('foo'),"\n"; #return 1


B<WARNING> This method should be carefully called. Some internal mechanism, like the layout system, uses the meta class of one object.

example:

    my $hello = QPushButton("Hello world!");
    $hello->add_meta('QLineEdit'); #very bad

=cut

sub add_meta {
    my $self = shift;
    my $class_name = shift;
    return if (!defined $class_name);
    $class_name =~ s/.*:://g;
    $self->{'meta_type_list'}->{$class_name} = 1;    
}

=pod

=head3 set_properity($properity_name,$properity_value)

set a properity valued C<$properity_value> to properity name C<$properity_name>.

=cut

sub set_properity {
    my $self = shift;
    my $pn = shift;
    my $pv = shift;
    return if (!defined $pn);
    $pv = '' if (!defined $pv);
    $self->{'properities'}->{$pn} = $pv;    
}

=pod

=head3 properity($properity_name)

returns the properity valued of properity name C<$properity_name>.

=cut

sub properity {
    my $self = shift;
    my $pn = shift;
    return undef if (!defined $pn);
    return $self->{'properities'}->{$pn};    
}

=pod

=head3 register_signal_map($signal_name_map)

Add signals to the signal list of the widget. C<$signal_name_map> can be a list reference or hash reference.

example:
    
    sub slot {
        my ($p_connect,$p_emit) = @_;
        
        if (defined $p_connect) {
            print "\$p_connect = $p_connect\n";
        }
        if (defined $p_emit) {
            print "\$p_emit = $p_emit\n";
        }    
    }
    
    my $w = QObject();
    $w->register_signal_map(['signal1','signal2']);
    $w->{signal1}->connect(\&slot,'connect signal1');
    $w->{signal2}->connect(\&slot,'connect signal2');
    $w->{signal1}->emit('emit signal1');    
  

=cut

sub register_signal {
    my $self = shift;
    my $signal_name = shift;
       
    if (!defined ($self->{'signal_object_list'}->{$signal_name})) {
        $self->{'signal_object_list'}->{$signal_name} = Qt::signal->new($self,$signal_name);
    }
    
    return $self->{'signal_object_list'}->{$signal_name};
}

sub register_signal_map {
    my $self = shift;
    my $signal_name_map = shift;    
    if (ref($signal_name_map) eq 'HASH') {
        foreach (keys %$signal_name_map) {
            $self->{$_} = $self->register_signal($signal_name_map->{$_}); 
        }
    }
    if (ref($signal_name_map) eq 'ARRAY') {
        foreach (@$signal_name_map) {
            $self->{$_} = $self->register_signal($_); 
        }        
    }
}

sub _print {
    my $self = shift;
    print ref($self)." (".$self->{id}.")";
}

1;