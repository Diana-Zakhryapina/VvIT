PGDMP     0                    {            mtuci_db    15.1    15.1     0           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            1           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            2           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            3           1262    16499    mtuci_db    DATABASE     �   CREATE DATABASE mtuci_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = icu LOCALE = 'en_US.UTF-8' ICU_LOCALE = 'en-US';
    DROP DATABASE mtuci_db;
                postgres    false            �            1259    16556    chair    TABLE     �   CREATE TABLE public.chair (
    id integer NOT NULL,
    name character varying NOT NULL,
    deanery character varying NOT NULL
);
    DROP TABLE public.chair;
       public         heap    diana    false            �            1259    16555    chair_id_seq    SEQUENCE     �   CREATE SEQUENCE public.chair_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.chair_id_seq;
       public          diana    false    215            4           0    0    chair_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.chair_id_seq OWNED BY public.chair.id;
          public          diana    false    214            �            1259    16656    student    TABLE     �   CREATE TABLE public.student (
    id integer NOT NULL,
    full_name character varying NOT NULL,
    passport character varying(10) NOT NULL,
    group_numb integer
);
    DROP TABLE public.student;
       public         heap    diana    false            �            1259    16633    student_group    TABLE     w   CREATE TABLE public.student_group (
    id integer NOT NULL,
    numb character varying NOT NULL,
    chair integer
);
 !   DROP TABLE public.student_group;
       public         heap    diana    false            �            1259    16632    student_group_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.student_group_id_seq;
       public          diana    false    217            5           0    0    student_group_id_seq    SEQUENCE OWNED BY     M   ALTER SEQUENCE public.student_group_id_seq OWNED BY public.student_group.id;
          public          diana    false    216            �            1259    16655    student_id_seq    SEQUENCE     �   CREATE SEQUENCE public.student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.student_id_seq;
       public          diana    false    219            6           0    0    student_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.student_id_seq OWNED BY public.student.id;
          public          diana    false    218            �           2604    16559    chair id    DEFAULT     d   ALTER TABLE ONLY public.chair ALTER COLUMN id SET DEFAULT nextval('public.chair_id_seq'::regclass);
 7   ALTER TABLE public.chair ALTER COLUMN id DROP DEFAULT;
       public          diana    false    215    214    215            �           2604    16659 
   student id    DEFAULT     h   ALTER TABLE ONLY public.student ALTER COLUMN id SET DEFAULT nextval('public.student_id_seq'::regclass);
 9   ALTER TABLE public.student ALTER COLUMN id DROP DEFAULT;
       public          diana    false    218    219    219            �           2604    16636    student_group id    DEFAULT     t   ALTER TABLE ONLY public.student_group ALTER COLUMN id SET DEFAULT nextval('public.student_group_id_seq'::regclass);
 ?   ALTER TABLE public.student_group ALTER COLUMN id DROP DEFAULT;
       public          diana    false    217    216    217            )          0    16556    chair 
   TABLE DATA           2   COPY public.chair (id, name, deanery) FROM stdin;
    public          diana    false    215   .       -          0    16656    student 
   TABLE DATA           F   COPY public.student (id, full_name, passport, group_numb) FROM stdin;
    public          diana    false    219   g       +          0    16633    student_group 
   TABLE DATA           8   COPY public.student_group (id, numb, chair) FROM stdin;
    public          diana    false    217   z       7           0    0    chair_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.chair_id_seq', 2, true);
          public          diana    false    214            8           0    0    student_group_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.student_group_id_seq', 4, true);
          public          diana    false    216            9           0    0    student_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.student_id_seq', 20, true);
          public          diana    false    218            �           2606    16563    chair chair_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.chair
    ADD CONSTRAINT chair_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.chair DROP CONSTRAINT chair_pkey;
       public            diana    false    215            �           2606    16640     student_group student_group_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.student_group
    ADD CONSTRAINT student_group_pkey PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.student_group DROP CONSTRAINT student_group_pkey;
       public            diana    false    217            �           2606    16663    student student_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.student DROP CONSTRAINT student_pkey;
       public            diana    false    219            �           2606    16641 &   student_group student_group_chair_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student_group
    ADD CONSTRAINT student_group_chair_fkey FOREIGN KEY (chair) REFERENCES public.chair(id);
 P   ALTER TABLE ONLY public.student_group DROP CONSTRAINT student_group_chair_fkey;
       public          diana    false    3475    217    215            �           2606    16664    student student_group_numb_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.student
    ADD CONSTRAINT student_group_numb_fkey FOREIGN KEY (group_numb) REFERENCES public.student_group(id);
 I   ALTER TABLE ONLY public.student DROP CONSTRAINT student_group_numb_fkey;
       public          diana    false    3477    219    217            )   )   x�3�0�¬;.̸��Dpq^X�/������ ��      -     x�]�]nA��{O�'@��3�sc"@L"��D�K�
ǻ^��s#�g�<ز��T�T�-���\2�]+2�Q�eM�Y���6���2�'x?��[����d��쓋�CN�=ɥL�EUY�G�?�p'�*QȾ�+Z�cLr�O˺��C+۲)� �qG�Yà�@�Ivji��
cv�3�=9�}N`����2���Z��@
�7.�5�����)�k�RV�99�&��Cl�z^C{_�YC~��J��,�L��W��;Г�N�iD�])��0���4��|�C3����=�^���j�Z��J�����]5a�K!zΞ|cQ�[��>j �k%u�1pf�4:�X���O��Zǣ~	�Դ��x�<ʻ�mzFr��YC�kF�}7�N@���?�D�٩�#u��A<(�oj�vT@�и�h�3&��ۉ��k"��<*�ZU��v=�N����c9S�XP��Q9��~Z�V� �d]Θ2X��Ti����f��������xy��i�ߧz͢      +   /   x�3�0�¤��9��\# ��5�q� �F@n� /�     