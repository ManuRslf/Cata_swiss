import streamlit as st
import mysql.connector as db
import pandas as pd
import numpy as np
import os
import datetime
from datetime import datetime
st.set_page_config(layout="wide")

def normalisation_attribut(att):
    if att == 'TemperatureMaxDegre': return 'Temperature maximale'
    if att == 'CourtDEau': return 'Court d\'eau'
    if att == 'VolumeRocheM3': return 'Volume des roches'
    if att == 'VolumeTombeeM3': return 'Volume des roches tombées'
    if att == 'DiametreGrelonCM': return 'Diamètre grelons (cm)'
    if att == 'HABrulee': return 'Hectares brulées '
    if att == 'VitesseVentMaxKMH': return 'Vitesse max du vent (km)'
    if att == 'Magnitude': return 'Magnitude'
    return 'Date'

# Fonction pour se connecter à la base de données
def connection_to_DB():
    return db.connect(
        host='127.0.0.1',
        database='cata_swiss',
        user='root',
        password='xxxx',
        port='3306'
    )

# Fonction pour obtenir toutes les catastrophes naturelles de la base de données
def get_catastropheNaturelle():
    conn = connection_to_DB()
    query = "SELECT * FROM CatastropheNaturelle"
    data = pd.read_sql(query, conn)
    conn.close()
    return data

# Fonction pour obtenir les types de catastrophes disponibles
def get_catastrophe_types():
    return ["Canicule", "Eboulement", "TremblementDeTerre", "Avalanche", "Crue", "Incendie", "GlissementDeTerrain", "Grele", "Tempete"]

# Fonction pour obtenir les informations sur les catastrophes d'un type donné
def get_catastrophes_by_type(catastrophe_type):
    conn = connection_to_DB()
    query = f"""
        SELECT 
            c.IDCatastrophe,
            l.Localite,
            l.Region,
            s.NBVictime,
            d.Explication,
            d.image_name
        FROM 
            CatastropheNaturelle c
        JOIN 
            Statistique s ON c.IDStatistique = s.IDStatistique
        JOIN 
            Lieu l ON c.IDLieu = l.IDLieu
        JOIN 
            Description d ON c.IDDescription = d.IDDescription
        JOIN 
            {catastrophe_type} t ON c.IDCatastrophe = t.IDCatastrophe
    """
    data = pd.read_sql(query, conn)
    conn.close()
    return data



# Fonction pour obtenir les informations sur les 10 catastrophes les plus mortelles
def get_top_10_mortelles():
    conn = connection_to_DB()
    query = """
        SELECT 
            c.IDCatastrophe,
            l.Localite,
            l.Region,
            s.NBVictime
        FROM 
            CatastropheNaturelle c
        JOIN 
            Statistique s ON c.IDStatistique = s.IDStatistique
        JOIN 
            Lieu l ON c.IDLieu = l.IDLieu
        ORDER BY 
            s.NBVictime DESC
        LIMIT 10;
    """
    data = pd.read_sql(query, conn)
    conn.close()
    return data

#fonction pour obtenir les catas filtré selon les dates
def get_cata_bydate(catastrophe_type, datefin):
    conn = connection_to_DB()
    query = f"""
    SELECT 
        c.IDCatastrophe,
        l.Localite,
        l.Region,
        s.NBVictime,
        d.Explication,
        d.image_name,
        d1.DateDebut,
        d1.DateFin
    FROM 
        CatastropheNaturelle c
    JOIN 
        Statistique s ON c.IDStatistique = s.IDStatistique
    JOIN 
        Lieu l ON c.IDLieu = l.IDLieu
    JOIN 
        Description d ON c.IDDescription = d.IDDescription
    join 
        Duree d1 on c.IDDuree = d1.IDDuree 
    JOIN 
        {catastrophe_type} t ON c.IDCatastrophe = t.IDCatastrophe
    where year(d1.DateFin) <= {datefin};
    """
    data = pd.read_sql(query, conn)
    conn.close()
    return data

#fonction pour recuperer les details unique de chaque cata
def get_cata_special(catastrophe_type, date):
    conn = connection_to_DB()
    
    query0 = f"""
    SHOW COLUMNS FROM {catastrophe_type};
    """
    
    data0 = pd.read_sql(query0, conn)
    
    if len(data0['Field']) == 2:
        return {}
    column_3 = data0['Field'][2] 
    query = f"""
    SELECT 
        {catastrophe_type}.*,
        YEAR(d1.DateDebut) as Date
    FROM 
        {catastrophe_type}
    JOIN 
        catastrophenaturelle c  ON {catastrophe_type}.IDCatastrophe = c.IDCatastrophe
    JOIN
        duree d1 ON c.IDDuree = d1.IDDuree
    WHERE YEAR(d1.DateDebut) <= {date}
            AND {catastrophe_type}.{column_3} IS NOT NULL
    """
    data = pd.read_sql(query, conn)
    if data.empty: return {}
    
    data_to_list = list(data.items())
    print(data_to_list)
    if len(data_to_list) == 4:
        select = data_to_list[2:4] 
        conn.close()
        return dict(select)
    if len(data_to_list) == 5:
        select = data_to_list[2:5] 
        conn.close()
        return dict(select)  
    conn.close()
    return {}


st.title('Base de donnée des plus grosses catastrophes naturelles répertoriées en Suisse')

#deux colonne
col1, col2 = st.columns(2)
#-------------------------------------------------------------------------------
#toggle effect du bouton (nb bouton actuel: 4)
if 'button' not in st.session_state:
    st.session_state.button = False

if 'button2' not in st.session_state:
    st.session_state.button2 = False

if 'button3' not in st.session_state:
    st.session_state.button3 = False
    
if 'button4' not in st.session_state:
    st.session_state.button4 = False
    
def click_button():
    st.session_state.button = not st.session_state.button

def click_button2():
    st.session_state.button2 = not st.session_state.button2
    
def click_button3():
    st.session_state.button3 = not st.session_state.button3
    
def click_button4():
    st.session_state.button4 = not st.session_state.button4
    




with col1:
    # Bouton pour afficher toutes les catastrophes
    if st.button('Afficher toutes les catastrophes', on_click=click_button):
        if st.session_state.button:
            catastrophes_df = get_catastropheNaturelle()
            st.write(catastrophes_df)
    # Bouton pour afficher les 10 catastrophes les plus mortelles     
    if st.button('Afficher les 10 catastrophes les plus mortelles', on_click=click_button3):

        if st.session_state.button3:
            top_10_mortelles_df = get_top_10_mortelles()
            st.write(top_10_mortelles_df)

    # Menu déroulant pour sélectionner le type de catastrophe
    catastrophe_type = st.selectbox('Sélectionnez un type de catastrophe', get_catastrophe_types())
    





###DEUXIEME COLONNE
with col2:
    #creation du widget pour le filtre
    if st.session_state.button2:
        datefiltre = st.number_input(f"{catastrophe_type}s jusqu'en ", min_value=0, value=0, step=1)
        
        if st.button('Filtrer', type='primary'):
            catastrophes_df = get_cata_bydate(catastrophe_type, datefiltre)
            
            if catastrophes_df.empty:
                st.write(f"Pas de {catastrophe_type}s.")
            for index, row in catastrophes_df.iterrows():
                st.subheader(f"Catastrophe ID: {row['IDCatastrophe']}")
                print(row['Localite'])
                if row['Localite'] == "None":
                    st.write(f"Localité: inconnu")
                else:
                    st.write(f"Localité: {row['Localite']}")        
                st.write(f"Région: {row['Region']}")
                if row['NBVictime'] == "nan":
                    st.write(f"Nombre de victimes: inconnu")
                else:
                    st.write(f"Nombre de victimes: {row['NBVictime']}")
                
                if row['DateDebut'][-2:] == row['DateFin'][-2:]:
                    st.write(f"Date: {row['DateDebut']}")  
                else: 
                    st.write(f"Date de debut: {row['DateDebut']}")
                    st.write(f"Date de debut: {row['DateFin']}")
                st.write(f"Description: {row['Explication']}")
                
                
                
                image_path = os.path.join('Images\\', row['image_name'])
                if os.path.exists(image_path):
                    st.image(image_path)
                else:
                    st.write("Image non disponible")
                
            with col1:
                #affichage des particularités d'une catastrophe
                cata_spec = get_cata_special(catastrophe_type, datefiltre)
                
                st.header(f"Données relatives aux {catastrophe_type}s")
                if cata_spec == {}: st.write("Pas d'information.")
                else:
                    final = {normalisation_attribut(key): cata_spec[key] for key in cata_spec}
                    # Convertir les données en DataFrame
                    # Convertir les données en DataFrame
                    df = pd.DataFrame(final)


                    st.write(df)



    
    
    # Bouton pour afficher les catastrophes du type sélectionné
    if st.button(f'Afficher les {catastrophe_type}s', on_click=click_button2):

        if st.session_state.button2:
            catastrophes_df = get_catastrophes_by_type(catastrophe_type)
            for index, row in catastrophes_df.iterrows():
                st.subheader(f"Catastrophe ID: {row['IDCatastrophe']}")
                print(row['Localite'])
                if row['Localite'] == "None":
                    st.write(f"Localité: inconnu")
                else:
                    st.write(f"Localité: {row['Localite']}")        
                st.write(f"Région: {row['Region']}")
                if row['NBVictime'] == "nan":
                    st.write(f"Nombre de victimes: inconnu")
                else:
                    st.write(f"Nombre de victimes: {row['NBVictime']}")
                st.write(f"Description: {row['Explication']}")
                
                image_path = os.path.join('Images\\', row['image_name'])
                if os.path.exists(image_path):
                    st.image(image_path)
                else:
                    st.write("Image non disponible")
    

    


    

