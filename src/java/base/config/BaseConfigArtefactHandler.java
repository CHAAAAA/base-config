package base.config;

import org.codehaus.groovy.grails.commons.ArtefactHandlerAdapter;

public final class BaseConfigArtefactHandler extends ArtefactHandlerAdapter {
    public static final String TYPE = "BaseConfig";

    public BaseConfigArtefactHandler() {
        super(TYPE, BaseConfigGrailsClass.class, DefaultBaseConfigGrailsClass.class, null);
    }

    public boolean isArtefactClass(@SuppressWarnings("rawtypes") Class clazz) {
        return clazz != null && clazz.getName().endsWith(TYPE);
    }
}
