package ke.co.mspace.nonsmppmanager.service;

import org.hibernate.Session;

import ke.co.mspace.nonsmppmanager.model.SMSCredits;
import ke.co.mspace.nonsmppmanager.util.HibernateUtil;

/**
 *
 * @author Norrey Osako
 */
public class ManageCreditImpl implements ManageCreditApi {

   

    

    @Override
    public void persistUpdate(SMSCredits smsCredits) {
        
        Session session = HibernateUtil.getSessionFactory().getCurrentSession();

        session.getTransaction().begin();
        session.save(smsCredits);
        session.getTransaction().commit();
        
    }

 
}
