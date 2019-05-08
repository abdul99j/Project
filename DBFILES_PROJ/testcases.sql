INSERT INTO users values ('MAIRAJ MUHAMMAD','MAIRAJ','MUHAMMAD','loki','user','b.madrid84@yahoo.com','1997-11-26','M')
INSERT INTO users values ('ABDUL SAMAD','ADBUL','SAMAD','asd','user','b.madrid84@yahoo.com','1997-11-26','M')
INSERT INTO users values ('SHEHRI ','SHEHRI','abc','ads','user','b.madrid84@yahoo.com','1991-12-26','M')

alter table review alter column reviewDescription nvarchar(500)
alter table review add dateGiven date

INSERT INTO review([gameID],[reviewID],[userName],[rating],[reviewDescription],[dateGiven])values(1,1,'ABDUL SAMAD',4,'LOL','29-JUL-2018')
INSERT INTO review([gameID],[reviewID],[userName],[rating],[reviewDescription],[dateGiven]) values (2,2,'ABDUL SAMAD',5,'BED','29-JUN-2018')

INSERT INTO review([gameID],[reviewID],[userName],[rating],[reviewDescription],[dateGiven]) values (4,5,'SHEHRI DON',5,'xD','29-AUG-2018')
INSERT INTO review([gameID],[reviewID],[userName],[rating],[reviewDescription],[dateGiven]) values (5,4,'SHEHRI DON',5,'XYZ','29-JAN-2019')
INSERT INTO review([gameID],[reviewID],[userName],[rating],[reviewDescription],[dateGiven]) values (6,3,'SHEHRI DON',5,'ABC','29-JUL-2017')
INSERT INTO review([gameID],[reviewID],[userName],[rating],[reviewDescription],[dateGiven]) values (7,4,'MAIRAJ MUHAMMAD',3,'LMAO','28-FEB-2019')

INSERT INTO games values (1,'POP','description','1992-12-1','FPS','EA')
INSERT INTO games values (2,'COD','description','1993-12-1','FPS','CA')
INSERT INTO games values (3,'LOC','description','1994-12-1','FPS','DA')
INSERT INTO games values (4,'COC','description','1995-12-1','FPS','FA')
INSERT INTO games values (5,'LOL','description','1992-9-1','FPS','LA')
INSERT INTO games values (6,'XYZ','description','1992-9-1','STRTG','LA')