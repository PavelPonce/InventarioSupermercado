GO
CREATE PROCEDURE [Acce].[SP_Usuario_Login]
	@Usuario NVARCHAR(50),
	@Contrasena NVARCHAR(MAX)
AS
BEGIN
		DECLARE @HASHBYTES NVARCHAR(MAX) = CONVERT(NVARCHAR (MAX), HASHBYTES ('SHA2_512', @Contrasena), 2);		
		SELECT	usu.*,
				rol.Roles_Descripcion AS Roles_Descripcion,
				emp.Emple_Id AS Emple_Id,
				CONCAT(emp.Emple_PrimerNombre,' ',
					CASE WHEN emp.Emple_SegundoNombre IS NULL THEN '' ELSE emp.Emple_SegundoNombre + ' ' END,
					emp.Emple_PrimerApellido, 
					CASE WHEN emp.Emple_SegundoApellido IS NULL THEN '' ELSE ' ' + emp.Emple_SegundoApellido END
				) AS Emple_NombreCompleto
		FROM Acce.tbUsuarios AS usu INNER JOIN Acce.tbRoles AS rol
		ON rol.Roles_Id = usu.Roles_Id INNER JOIN Supr.tbEmpleados AS emp
		ON emp.Emple_Id = usu.Emple_Id
		WHERE usu.Usuar_Usuario = @Usuario AND usu.Usuar_Contrasena = @HASHBYTES;
END
GO
CREATE PROCEDURE Supr.SP_Productos_Lista
	@Categ_Id INT
AS
BEGIN
	SELECT	pro.*,
			uni.Unida_Descripcion,
			prv.Prove_Marca
	FROM Supr.tbProductos AS pro INNER JOIN Gral.tbUnidades AS uni
	ON pro.Unida_Id = uni.Unida_Id INNER JOIN Supr.tbProveedores AS prv
	ON pro.Prove_Id = prv.Prove_Id
	WHERE pro.Categ_Id = @Categ_Id
END
GO
CREATE PROCEDURE Supr.SP_Productos_Buscar
	@Produ_Id INT
AS
BEGIN
	SELECT	pro.*,
			uni.Unida_Descripcion,
			prv.Prove_Marca,
			usu.Usuar_Usuario AS UsuarioCreacion,
			usr.Usuar_Usuario AS UsuarioModificacion
	FROM Supr.tbProductos AS pro INNER JOIN Gral.tbUnidades AS uni
	ON pro.Unida_Id = uni.Unida_Id INNER JOIN Supr.tbProveedores AS prv
	ON pro.Prove_Id = prv.Prove_Id INNER JOIN Acce.tbUsuarios AS usu
	ON pro.Produ_UsuarioCreacion = usu.Usuar_Id LEFT JOIN Acce.tbUsuarios AS usr
	ON pro.Produ_UsuarioModificacion = usr.Usuar_Id
	WHERE pro.Produ_Id = @Produ_Id
END
GO
CREATE PROCEDURE Supr.SP_Productos_Insertar
(
    @Produ_Descripcion NVARCHAR(50),
    @Produ_Existencia INT,
    @Unida_Id INT,
    @Produ_PrecioCompra NUMERIC(8,2),
    @Produ_PrecioVenta NUMERIC(8,2),
    @Impue_Id INT,
    @Categ_Id INT,
    @Prove_Id INT,
    @Sucur_Id INT,
    @Produ_UsuarioCreacion INT,
    @Produ_FechaCreacion DATETIME
)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Supr.tbProductos (Produ_Descripcion, Produ_Existencia, Unida_Id, Produ_PrecioCompra, Produ_PrecioVenta, Impue_Id, Categ_Id, Prove_Id, Sucur_Id, Produ_UsuarioCreacion, Produ_FechaCreacion)
        VALUES (@Produ_Descripcion, @Produ_Existencia, @Unida_Id, @Produ_PrecioCompra, @Produ_PrecioVenta, @Impue_Id, @Categ_Id, @Prove_Id, @Sucur_Id, @Produ_UsuarioCreacion, @Produ_FechaCreacion);
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END

GO

CREATE PROCEDURE Supr.SP_Productos_Modificar
(
    @Produ_Id INT,
    @Produ_Descripcion NVARCHAR(50),
    @Produ_Existencia INT,
    @Unida_Id INT,
    @Produ_PrecioCompra NUMERIC(8,2),
    @Produ_PrecioVenta NUMERIC(8,2),
    @Impue_Id INT,
    @Categ_Id INT,
    @Prove_Id INT,
    @Sucur_Id INT,
    @Produ_UsuarioModificacion INT,
    @Produ_FechaModificacion DATETIME
)
AS
BEGIN
    BEGIN TRY
        UPDATE Supr.tbProductos
        SET Produ_Descripcion = @Produ_Descripcion,
            Produ_Existencia = @Produ_Existencia,
            Unida_Id = @Unida_Id,
            Produ_PrecioCompra = @Produ_PrecioCompra,
            Produ_PrecioVenta = @Produ_PrecioVenta,
            Impue_Id = @Impue_Id,
            Categ_Id = @Categ_Id,
            Prove_Id = @Prove_Id,
            Sucur_Id = @Sucur_Id,
            Produ_UsuarioModificacion = @Produ_UsuarioModificacion,
            Produ_FechaModificacion = @Produ_FechaModificacion
        WHERE Produ_Id = @Produ_Id;
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END

GO

CREATE PROCEDURE Supr.SP_Productos_Eliminar
(
    @Produ_Id INT,
    @Produ_UsuarioModificacion INT,
    @Produ_FechaModificacion DATETIME
)
AS
BEGIN
    BEGIN TRY
        UPDATE Supr.tbProductos
        SET Produ_Estado = 0,
            Produ_UsuarioModificacion = @Produ_UsuarioModificacion,
            Produ_FechaModificacion = @Produ_FechaModificacion
        WHERE Produ_Id = @Produ_Id;
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END
GO
CREATE PROCEDURE Venta.SP_VentasEncabezado_Lista
AS
BEGIN
	SELECT	ven.*,
			suc.Sucur_Descripcion
	FROM Venta.tbVentasEncabezado AS ven INNER JOIN Supr.tbSucursales AS suc
	ON ven.Sucur_Id = suc.Sucur_Id
END
GO
CREATE PROCEDURE Venta.SP_VentasEncabezado_Buscar
	@Venen_Id INT
AS
BEGIN
	SELECT	ven.*,
			usu.Usuar_Usuario AS UsuarioCreacion,
			usr.Usuar_Usuario AS UsuarioModificacion
	FROM Venta.tbVentasEncabezado AS ven INNER JOIN Supr.tbSucursales AS suc
	ON ven.Sucur_Id = suc.Sucur_Id INNER JOIN Acce.tbUsuarios AS usu
	ON ven.Venen_UsuarioCreacion = usu.Usuar_Id LEFT JOIN Acce.tbUsuarios AS usr
	ON ven.Venen_UsuarioModificacion = usr.Usuar_Id
	WHERE ven.Venen_Id = @Venen_Id
END
GO
CREATE PROCEDURE Venta.SP_VentasEncabezado_Insertar
(
    @Sucur_Id INT,
    @Venen_DireccionEnvio NVARCHAR(MAX),
    @Venen_FechaPedido DATE,
    @Venen_UsuarioCreacion INT,
    @Venen_FechaCreacion DATETIME
)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Venta.tbVentasEncabezado (Sucur_Id, Venen_DireccionEnvio, Venen_FechaPedido, Venen_UsuarioCreacion, Venen_FechaCreacion)
        VALUES (@Sucur_Id, @Venen_DireccionEnvio, @Venen_FechaPedido, @Venen_UsuarioCreacion, @Venen_FechaCreacion);
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END

GO

CREATE PROCEDURE Venta.SP_VentasEncabezado_Modificar
(
    @Venen_Id INT,
    @Sucur_Id INT,
    @Venen_DireccionEnvio NVARCHAR(MAX),
    @Venen_FechaPedido DATE,
    @Venen_UsuarioModificacion INT,
    @Venen_FechaModificacion DATETIME
)
AS
BEGIN
    BEGIN TRY
        UPDATE Venta.tbVentasEncabezado
        SET Sucur_Id = @Sucur_Id,
            Venen_DireccionEnvio = @Venen_DireccionEnvio,
            Venen_FechaPedido = @Venen_FechaPedido,
            Venen_UsuarioModificacion = @Venen_UsuarioModificacion,
            Venen_FechaModificacion = @Venen_FechaModificacion
        WHERE Venen_Id = @Venen_Id;
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END

GO

CREATE PROCEDURE Venta.SP_VentasEncabezado_Desactivar
(
    @Venen_Id INT,
    @Venen_UsuarioModificacion INT,
    @Venen_FechaModificacion DATETIME
)
AS
BEGIN
    BEGIN TRY
        UPDATE Venta.tbVentasEncabezado
        SET Venen_Estado = 0,
            Venen_UsuarioModificacion = @Venen_UsuarioModificacion,
            Venen_FechaModificacion = @Venen_FechaModificacion
        WHERE Venen_Id = @Venen_Id;
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END
GO
CREATE PROCEDURE Venta.SP_VentasEncabezado_Eliminar
(
    @Venen_Id INT
)
AS
BEGIN
    BEGIN TRY
        DELETE FROM Venta.tbVentasEncabezado
        WHERE Venen_Id = @Venen_Id;
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END
GO
CREATE PROCEDURE Venta.SP_VentasDetalle_List
AS
BEGIN
	SELECT	ven.*,
			pro.Produ_Descripcion,
			pro.Produ_PrecioVenta
	FROM Venta.tbVentasDetalle AS ven INNER JOIN Supr.tbProductos AS pro
	ON ven.Produ_Id = pro.Produ_Id
	ORDER BY ven.Venen_Id ASC
END
GO
CREATE PROCEDURE Venta.SP_VentasDetalle_Buscar
	@Venen_Id INT
AS
BEGIN
	SELECT	ven.*,
			pro.Produ_Descripcion,
			pro.Produ_PrecioVenta
	FROM Venta.tbVentasDetalle AS ven INNER JOIN Supr.tbProductos AS pro
	ON ven.Produ_Id = pro.Produ_Id
	WHERE ven.Venen_Id = @Venen_Id
END
GO
CREATE PROCEDURE Venta.SP_VentasDetalle_Insertar
(
    @Venen_Id INT,
    @Produ_Id INT,
    @Vende_Cantidad INT,
    @Vende_UsuarioCreacion INT,
    @Vende_FechaCreacion DATETIME
)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Venta.tbVentasDetalle (Venen_Id, Produ_Id, Vende_Cantidad, Vende_UsuarioCreacion, Vende_FechaCreacion)
        VALUES (@Venen_Id, @Produ_Id, @Vende_Cantidad, @Vende_UsuarioCreacion, @Vende_FechaCreacion);
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END

GO

CREATE PROCEDURE Venta.SP_VentasDetalle_Modificar
(
    @Vende_Id INT,
    @Venen_Id INT,
    @Produ_Id INT,
    @Vende_Cantidad INT,
    @Vende_UsuarioModificacion INT,
    @Vende_FechaModificacion DATETIME
)
AS
BEGIN
    BEGIN TRY
        UPDATE Venta.tbVentasDetalle
        SET Venen_Id = @Venen_Id,
            Produ_Id = @Produ_Id,
            Vende_Cantidad = @Vende_Cantidad,
            Vende_UsuarioModificacion = @Vende_UsuarioModificacion,
            Vende_FechaModificacion = @Vende_FechaModificacion
        WHERE Vende_Id = @Vende_Id;
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END

GO

CREATE PROCEDURE Venta.SP_VentasDetalle_Desactivar
(
    @Vende_Id INT,
    @Vende_UsuarioModificacion INT,
    @Vende_FechaModificacion DATETIME
)
AS
BEGIN
    BEGIN TRY
        UPDATE Venta.tbVentasDetalle
        SET Vende_Estado = 0,
            Vende_UsuarioModificacion = @Vende_UsuarioModificacion,
            Vende_FechaModificacion = @Vende_FechaModificacion
        WHERE Vende_Id = @Vende_Id;
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END
GO
CREATE PROCEDURE Venta.SP_VentasDetalle_Eliminar
(
    @Vende_Id INT
)
AS
BEGIN
    BEGIN TRY
        DELETE FROM Venta.tbVentasDetalle
        WHERE Vende_Id = @Vende_Id;
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END
GO
CREATE PROCEDURE Comp.SP_ComprasEncabezado_Lista
AS
BEGIN
    SELECT ce.*,
           prov.Prove_Marca,
           suc.Sucur_Descripcion,
		   CONCAT(emp.Emple_PrimerNombre,' ',
					CASE WHEN emp.Emple_SegundoNombre IS NULL THEN '' ELSE emp.Emple_SegundoNombre + ' ' END,
					emp.Emple_PrimerApellido, 
					CASE WHEN emp.Emple_SegundoApellido IS NULL THEN '' ELSE ' ' + emp.Emple_SegundoApellido END
				) AS Emple_NombreCompleto
    FROM Comp.tbComprasEncabezado AS ce
    INNER JOIN Supr.tbProveedores AS prov ON ce.Prove_Id = prov.Prove_Id
    INNER JOIN Supr.tbSucursales AS suc ON ce.Sucur_Id = suc.Sucur_Id
	INNER JOIN Supr.tbEmpleados AS emp ON ce.Emple_Id = emp.Emple_Id
END
GO
CREATE PROCEDURE Comp.SP_ComprasEncabezado_Buscar
    @Comen_Id INT
AS
BEGIN
    SELECT ce.*,
			prov.Prove_Marca,
           suc.Sucur_Descripcion,
		   CONCAT(emp.Emple_PrimerNombre,' ',
					CASE WHEN emp.Emple_SegundoNombre IS NULL THEN '' ELSE emp.Emple_SegundoNombre + ' ' END,
					emp.Emple_PrimerApellido, 
					CASE WHEN emp.Emple_SegundoApellido IS NULL THEN '' ELSE ' ' + emp.Emple_SegundoApellido END
				) AS Emple_NombreCompleto,
           usuCreacion.Usuar_Usuario AS UsuarioCreacion,
           usuModificacion.Usuar_Usuario AS UsuarioModificacion
    FROM Comp.tbComprasEncabezado AS ce
	INNER JOIN Supr.tbProveedores AS prov ON ce.Prove_Id = prov.Prove_Id
    INNER JOIN Supr.tbSucursales AS suc ON ce.Sucur_Id = suc.Sucur_Id
	INNER JOIN Supr.tbEmpleados AS emp ON ce.Emple_Id = emp.Emple_Id
    INNER JOIN Acce.tbUsuarios AS usuCreacion ON ce.Comen_UsuarioCreacion = usuCreacion.Usuar_Id
    LEFT JOIN Acce.tbUsuarios AS usuModificacion ON ce.Comen_UsuarioModificacion = usuModificacion.Usuar_Id
    WHERE ce.Comen_Id = @Comen_Id;
END
GO
CREATE PROCEDURE Comp.SP_ComprasEncabezado_Insertar
(
    @Prove_Id INT,
    @Sucur_Id INT,
    @Emple_Id INT,
    @Comen_FechaIngreso DATE,
    @Comen_UsuarioCreacion INT,
    @Comen_FechaCreacion DATETIME
)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Comp.tbComprasEncabezado (Prove_Id, Sucur_Id, Emple_Id, Comen_FechaIngreso, Comen_UsuarioCreacion, Comen_FechaCreacion)
        VALUES (@Prove_Id, @Sucur_Id, @Emple_Id, @Comen_FechaIngreso, @Comen_UsuarioCreacion, @Comen_FechaCreacion);
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END
GO
CREATE PROCEDURE Comp.SP_ComprasEncabezado_Modificar
(
    @Comen_Id INT,
    @Prove_Id INT,
    @Sucur_Id INT,
    @Emple_Id INT,
    @Comen_FechaIngreso DATE,
    @Comen_UsuarioModificacion INT,
    @Comen_FechaModificacion DATETIME
)
AS
BEGIN
    BEGIN TRY
        UPDATE Comp.tbComprasEncabezado
        SET Prove_Id = @Prove_Id,
            Sucur_Id = @Sucur_Id,
            Emple_Id = @Emple_Id,
            Comen_FechaIngreso = @Comen_FechaIngreso,
            Comen_UsuarioModificacion = @Comen_UsuarioModificacion,
            Comen_FechaModificacion = @Comen_FechaModificacion
        WHERE Comen_Id = @Comen_Id;
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END
GO
CREATE PROCEDURE Comp.SP_ComprasEncabezado_Desactivar
(
    @Comen_Id INT,
    @Comen_UsuarioModificacion INT,
    @Comen_FechaModificacion DATETIME
)
AS
BEGIN
    BEGIN TRY
        UPDATE Comp.tbComprasEncabezado
        SET Comen_Estado = 0,
            Comen_UsuarioModificacion = @Comen_UsuarioModificacion,
            Comen_FechaModificacion = @Comen_FechaModificacion
        WHERE Comen_Id = @Comen_Id;
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END
GO
CREATE PROCEDURE Comp.SP_ComprasEncabezado_Eliminar
(
    @Comen_Id INT
)
AS
BEGIN
    BEGIN TRY
        DELETE FROM Comp.tbComprasEncabezado
        WHERE Comen_Id = @Comen_Id;
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END
GO
CREATE PROCEDURE Comp.SP_ComprasDetalle_Lista
AS
BEGIN
    SELECT cd.*,
           prod.Produ_Descripcion,
           prod.Produ_PrecioCompra
    FROM Comp.tbComprasDetalle AS cd
    INNER JOIN Supr.tbProductos AS prod ON cd.Produ_Id = prod.Produ_Id
	ORDER BY cd.Comen_Id ASC
END
GO
CREATE PROCEDURE Comp.SP_ComprasDetalle_Buscar
    @Comde_Id INT
AS
BEGIN
    SELECT cd.*,
           prod.Produ_Descripcion,
           prod.Produ_PrecioCompra
    FROM Comp.tbComprasDetalle AS cd
    INNER JOIN Supr.tbProductos AS prod ON cd.Produ_Id = prod.Produ_Id
    WHERE cd.Comde_Id = @Comde_Id;
END
GO
CREATE PROCEDURE Comp.SP_ComprasDetalle_Insertar
(
    @Comen_Id INT,
    @Produ_Id INT,
    @Comde_Cantidad INT,
    @Unida_Id INT,
    @Comde_UsuarioCreacion INT,
    @Comde_FechaCreacion DATETIME
)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Comp.tbComprasDetalle (Comen_Id, Produ_Id, Comde_Cantidad, Comde_UsuarioCreacion, Comde_FechaCreacion)
        VALUES (@Comen_Id, @Produ_Id, @Comde_Cantidad, @Comde_UsuarioCreacion, @Comde_FechaCreacion);
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END
GO
CREATE PROCEDURE Comp.SP_ComprasDetalle_Modificar
(
    @Comde_Id INT,
    @Comen_Id INT,
    @Produ_Id INT,
    @Comde_Cantidad INT,
    @Comde_UsuarioModificacion INT,
    @Comde_FechaModificacion DATETIME
)
AS
BEGIN
    BEGIN TRY
        UPDATE Comp.tbComprasDetalle
        SET Comen_Id = @Comen_Id,
            Produ_Id = @Produ_Id,
            Comde_Cantidad = @Comde_Cantidad,
            Comde_UsuarioModificacion = @Comde_UsuarioModificacion,
            Comde_FechaModificacion = @Comde_FechaModificacion
        WHERE Comde_Id = @Comde_Id;
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END
GO
CREATE PROCEDURE Comp.SP_ComprasDetalle_Desactivar
(
    @Comde_Id INT,
    @Comde_UsuarioModificacion INT,
    @Comde_FechaModificacion DATETIME
)
AS
BEGIN
    BEGIN TRY
        UPDATE Comp.tbComprasDetalle
        SET Comde_Estado = 0,
            Comde_UsuarioModificacion = @Comde_UsuarioModificacion,
            Comde_FechaModificacion = @Comde_FechaModificacion
        WHERE Comde_Id = @Comde_Id;
        
        SELECT 1;
    END TRY
    BEGIN CATCH
        SELECT 0;
    END CATCH;
END
GO
CREATE PROCEDURE Comp.SP_ComprasDetalle_Eliminar
(
    @Comde_Id INT
)
AS
BEGIN
    BEGIN TRY
        DELETE FROM Comp.tbComprasDetalle
        WHERE Comde_Id = @Comde_Id
		SELECT 1
	END TRY
	BEGIN CATCH
		SELECT 0
	END CATCH
END
GO