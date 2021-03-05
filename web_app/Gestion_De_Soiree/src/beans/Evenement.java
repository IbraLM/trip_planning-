package beans;

public class Evenement {
	 /* Propriétés du bean */
    private Etudiant etudiant;
    private String nomEv;
    private String adresseDepart;
    private String adresseArrivee;
    private String zone;
    private String date;
    private String heure;

    public Etudiant getEtudiant() {
        return etudiant;
    }

    public void setEtudiant( Etudiant etudiant ) {
        this.etudiant = etudiant;
    }

    public String getnomEv() {
        return nomEv;
    }

    public void setnomEv(  String nomEv) {
        this.nomEv = nomEv;
    }
    
    public String getadDepart() {
    	return adresseDepart;
    }
    public void setadDepart( String adresseDepart) {
    	this.adresseDepart = adresseDepart;
    }
    
    public String getadArrivee () {
    	return adresseArrivee;
    }
    public void setadArrivee (String adresseArrivee) {
    	this.adresseArrivee = adresseArrivee;
    }
    public String getzone() {
        return zone;
    }

    public void setzone(  String zone) {
        this.zone = zone;
    }
    
    public String getdate() {
    	return date;
    }
    public void setdate( String date) {
    	this.date = date;
    }
    
    public String getheure () {
    	return heure;
    }
    public void setheure (String heure) {
    	this.heure = heure;
    }
  
}
