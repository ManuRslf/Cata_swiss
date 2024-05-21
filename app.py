import streamlit as st
import mysql.connector as db
import pandas as pd
import os
st.set_page_config(layout="wide")

# Fonction pour se connecter à la base de données
def connection_to_DB():
    return db.connect(
        host='127.0.0.1',
        database='cata_swiss',
        user='root',
        password='Isaroatelo123',
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




st.title('Base de donnée des plus grosses catastrophes naturelles répertoriées en Suisse')

#deux colonne
col1, col2 = st.columns(2)

#toggle effect du bouton (nb bouton actuel: 3)
if 'button' not in st.session_state:
    st.session_state.button = False

if 'button2' not in st.session_state:
    st.session_state.button2 = False

if 'button3' not in st.session_state:
    st.session_state.button3 = False
    
def click_button():
    st.session_state.button = not st.session_state.button

def click_button2():
    st.session_state.button2 = not st.session_state.button2
    
def click_button3():
    st.session_state.button3 = not st.session_state.button3



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


