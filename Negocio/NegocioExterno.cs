using System.Data;
using Datos;

namespace Negocio
{
    public class NegocioExterno
    {
        private readonly DaoExterno dao;

        public NegocioExterno()
        {
            dao = new DaoExterno();
        }

        public DataTable getProvincias()
        {
            return dao.getProvincias();
        }

        public DataTable getLocalidades(int idProvincia)
        {
            return dao.getLocalidades(idProvincia);
        }

        public DataTable getNacionalidades()
        {
            return dao.getNacionalidades();
        }

        public DataTable getEspecialidades()
        {
            return dao.getEspecialidades();
        }
    }
}
