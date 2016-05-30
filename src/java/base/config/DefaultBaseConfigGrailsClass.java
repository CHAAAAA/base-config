package base.config;

import org.codehaus.groovy.grails.commons.AbstractInjectableGrailsClass;

public class DefaultBaseConfigGrailsClass extends AbstractInjectableGrailsClass implements BaseConfigGrailsClass {

    public DefaultBaseConfigGrailsClass(Class<?> wrappedClass) {
        super(wrappedClass, BaseConfigArtefactHandler.TYPE);
    }

}
