import { Routes, Route } from 'react-router-dom';
import { PrivateRoute } from '../components/Auth/PrivateRoute';
import { Login } from '../pages/Auth/Login/Login';
import { Dashboard } from '../pages/Dashboard/Dashboard';
import { ListarMDFe } from '../pages/MDFe/ListarMDFe/ListarMDFe';
import { FormularioMDFe } from '../pages/MDFe/FormularioMDFe/FormularioMDFe';
import { DetalhesMDFe } from '../pages/MDFe/DetalhesMDFe/DetalhesMDFe';
import { ListarEmitentes } from '../pages/Emitentes/ListarEmitentes/ListarEmitentes';
import { ListarVeiculos } from '../pages/Veiculos/ListarVeiculos/ListarVeiculos';
import { ListarReboques } from '../pages/Reboques/ListarReboques/ListarReboques';
import { ListarCondutores } from '../pages/Condutores/ListarCondutores/ListarCondutores';
import { ListarContratantes } from '../pages/Contratantes/ListarContratantes/ListarContratantes';
import { ListarSeguradoras } from '../pages/Seguradoras/ListarSeguradoras/ListarSeguradoras';
import { ListarMunicipios } from '../pages/Municipios/ListarMunicipios/ListarMunicipios';
import { Usuarios } from '../pages/Admin/Usuarios';
import { Cargos } from '../pages/Admin/Cargos/Cargos';

export function AppRoutes() {
  return (
    <Routes>
      {/* Rotas públicas de autenticação */}
      <Route path="/login" element={<Login />} />

      {/* Rotas protegidas */}
      <Route path="/" element={
        <PrivateRoute>
          <Dashboard />
        </PrivateRoute>
      } />
      <Route path="/dashboard" element={
        <PrivateRoute>
          <Dashboard />
        </PrivateRoute>
      } />

      {/* MDFe */}
      <Route path="/mdfes" element={
        <PrivateRoute>
          <ListarMDFe />
        </PrivateRoute>
      } />
      <Route path="/mdfes/novo" element={
        <PrivateRoute>
          <FormularioMDFe />
        </PrivateRoute>
      } />
      <Route path="/mdfes/editar/:id" element={
        <PrivateRoute>
          <FormularioMDFe />
        </PrivateRoute>
      } />
      <Route path="/mdfes/visualizar/:id" element={
        <PrivateRoute>
          <DetalhesMDFe />
        </PrivateRoute>
      } />

      {/* Outras entidades - apenas listagem, CRUD via modal */}
      <Route path="/emitentes" element={
        <PrivateRoute>
          <ListarEmitentes />
        </PrivateRoute>
      } />
      <Route path="/veiculos" element={
        <PrivateRoute>
          <ListarVeiculos />
        </PrivateRoute>
      } />
      <Route path="/reboques" element={
        <PrivateRoute>
          <ListarReboques />
        </PrivateRoute>
      } />
      <Route path="/condutores" element={
        <PrivateRoute>
          <ListarCondutores />
        </PrivateRoute>
      } />
      <Route path="/contratantes" element={
        <PrivateRoute>
          <ListarContratantes />
        </PrivateRoute>
      } />
      <Route path="/seguradoras" element={
        <PrivateRoute>
          <ListarSeguradoras />
        </PrivateRoute>
      } />
      <Route path="/municipios" element={
        <PrivateRoute>
          <ListarMunicipios />
        </PrivateRoute>
      } />

      {/* Administração */}
      <Route path="/admin/usuarios" element={
        <PrivateRoute>
          <Usuarios />
        </PrivateRoute>
      } />
      <Route path="/admin/cargos" element={
        <PrivateRoute>
          <Cargos />
        </PrivateRoute>
      } />
    </Routes>
  );
}