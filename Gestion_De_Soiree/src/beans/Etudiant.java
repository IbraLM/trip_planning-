package beans;

public class Etudiant {
	 /* Propriétés du bean */
	private String pseudo;
    private String numeroE;
    private String nom;
    private String prenom;
    private String telephone;
    private String email;
    private String pass;
    private String walo;
    
    public void setpseudo(String pseudo){
        this.pseudo = pseudo;
    }
    public String getpseudo() {
        return pseudo;
    }
    
    public void setNumeroE( String numeroE ) {
        this.numeroE = numeroE;
    }
    public String getNumeroE() {
        return numeroE;
    }
    
    public void setNom( String nom ) {
        this.nom = nom;
    }

    public String getNom() {
        return nom;
    }

    public void setPrenom( String prenom ) {
        this.prenom = prenom;
    }

    public String getPrenom() {
        return prenom;
    }


    public String getTelephone() {
        return telephone;
    }

    public void setTelephone( String telephone ) {
        this.telephone = telephone;
    }

    public void setEmail( String email ) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }
    public void setpass( String pass ) {
        this.pass = pass;
    }

    public String getpass() {
        return pass;
    }
    public void setwalo( String walo ) {
        this.walo = walo;
    }

    public String getwalo() {
        return walo;
    }

}

